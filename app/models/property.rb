class Property < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  before_save :downcase_attributes
  validates :user_id,         presence: true
  validates :owner_name,      presence: true, length: { maximum: 50 }
  validates :property_type,   presence: true, inclusion: { in: %w(apartment
                                                                  house plot) }
  validates :property_status, presence: true, inclusion: { in: %w[sell rent
                                                                  sold] }
  validates :bed_rooms,       presence: true, inclusion: { in: %w[1bhk 2bhk
                                                                  3bhk 4bhk
                                                                  4+bhk na] }
  validates :area,            presence: true, numericality: { greater_than: 0 }
  validates :price,           presence: true, numericality: { greater_than: 0 }
  validates :street_address,  presence: true
  validates :locality,        presence: true
  validates :city,            presence: true
  validates :state,           presence: true
  VALID_PINCODE_REGEX = /\A[1-9][0-9]{5}\z/
  validates :pincode,         presence: true, 
                              format: { with: VALID_PINCODE_REGEX }
  validates :country,         presence: true
  
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
end
