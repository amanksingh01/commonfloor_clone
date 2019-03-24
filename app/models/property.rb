class Property < ApplicationRecord
  belongs_to :user

  has_many :wishlists,        dependent: :destroy
  has_many :interested_users, through:   :wishlists, source: :user
  has_many :comments,         dependent: :destroy

  before_save :downcase_attributes

  mount_uploader :picture, PictureUploader

  validates :user_id,         presence: true
  validates :owner_name,      presence: true, length: { maximum: 50 }
  validates :property_type,   presence: true, inclusion: { in: %w(apartment
                                                                  house plot) }
  validates :property_status, presence: true, inclusion: { in: %w[sell rent
                                                                  sold] }
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
  validate  :picture_size

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
  scope :bed_rooms, -> (bed_rooms) { where(bed_rooms:  bed_rooms) }
  scope :order_by,  -> (order_by)  { order(created_at: order_by) }
  scope :price,     -> (flag) do
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

  # Returns true if the user is interested in the property.
  def interested_user?(user)
    interested_users.include?(user)
  end

  # Sends interested user email.
  def send_interested_user_email(user)
    PropertyMailer.interested_user(self, user).deliver_now
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

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB.")
      end
    end
end
