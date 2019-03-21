class Comment < ApplicationRecord
  belongs_to :property
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :property_id, presence: true
  validates :user_id,     presence: true
  validates :comment,     presence: true, length: { maximum: 255 }
end