class Property < ApplicationRecord
  belongs_to :user
  belongs_to :approved_by, class_name: 'User', optional: true
  belongs_to :buyer,       class_name: 'User', optional: true

  has_many :wishlists,        dependent: :destroy
  has_many :interested_users, through:   :wishlists, source: :user
  has_many :comments,         dependent: :destroy

  has_one_attached :image

  before_save :downcase_attributes

  validates :user_id,         presence: true
  validates :owner_name,      presence: true, length: { maximum: 50 }
  validates :property_type,   presence: true, inclusion: { in: %w(apartment
                                                                  house plot) }
  validates :property_status, presence: true, inclusion: { in: %w[sell rent] }
  validates :bed_rooms,       presence: true, inclusion: { in: %w[1bhk 2bhk
                                                                  3bhk 4bhk
                                                                  4+bhk na] }
  validates :area,            presence: true, numericality: { greater_than: 0,
                                                              less_than: 10000 }
  validates :price,           presence: true,
                              numericality: { greater_than: 0,
                                              less_than: 1000000000 }
  validates :street_address,  presence: true
  validates :locality,        presence: true
  validates :city,            presence: true
  validates :state,           presence: true
  VALID_PINCODE_REGEX = /\A[1-9][0-9]{5}\z/
  validates :pincode,         presence: true, 
                              format: { with: VALID_PINCODE_REGEX }
  validates :country,         presence: true
  
  validate  :image_type
  validate  :image_size

  scope :area, -> (flag) do
    case flag
    when "1"
      where("area < ?", 1000)
    when "2"
      where(area: 1000..2500)
    when "3"
      where("area > ?", 2500)
    end
  end
  scope :bed_rooms,    -> (bed_rooms) { where(bed_rooms:  bed_rooms) }
  scope :include_sold, -> (value) do
    if value == 'yes'
      where(sold: [false, true])
    else
      where(sold: false)
    end
  end
  scope :order_by, -> (order_by)  { order(created_at: order_by) }
  scope :price,    -> (flag) do
    case flag
    when "1"
      where("price < ?", 10000)
    when "2"
      where(price: 10000..100000)
    when "3"
      where(price: 100000..5000000)
    when "4"
      where("price > ?", 5000000)
    end
  end
  scope :property_status, -> (status) { where(property_status: status) }
  scope :property_type,   -> (type)   { where(property_type:   type) }
  scope :search,          -> (keywords) do
    where("locality LIKE :pattern OR city LIKE :pattern",
          pattern: "%#{keywords.downcase}%")
  end

  # Returns true if the user is interested in the property.
  def interested_user?(user)
    interested_users.include?(user)
  end

  # Sends interested user email.
  def send_interested_user_email(user)
    PropertyMailer.interested_user(self, user).deliver_now
  end

  # Disapproves a property.
  def disapprove
    update_columns(approved: false, approved_at: nil, approved_by_id: nil)
  end

  # Approves a property.
  def approve(approved_by)
    update_columns(approved:       true,
                   approved_at:    Time.zone.now,
                   approved_by_id: approved_by.id)
  end

  # Sells a property to user.
  def sell(buyer)
    update_columns(sold:     true,
                   sold_at:  Time.zone.now,
                   buyer_id: buyer.id)
  end
  
  private

    # Converts property_type to all lower-case.
    def downcase_attributes
      owner_name.downcase!
      street_address.downcase!
      locality.downcase!
      city.downcase!
      state.downcase!
      country.downcase!
    end

    # Validates the type of an uploaded image.
    def image_type
      valid_image_type = %w[image/jpeg image/png]
      if image.attached? && !valid_image_type.include?(image.content_type)
        errors.add(:image, "needs to be a jpeg or png.")
        image.purge
      end
    end

    # Validates the size of an uploaded image.
    def image_size
      if image.attached? && image.byte_size > 5.megabytes
        errors.add(:image, "should be less than 5MB.")
        image.purge
      end
    end
end
