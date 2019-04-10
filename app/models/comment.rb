class Comment < ApplicationRecord
  belongs_to :property
  belongs_to :user
  belongs_to :approved_by, class_name: 'User', optional: true

  default_scope -> { order(created_at: :desc) }
  
  validates :property_id, presence: true
  validates :user_id,     presence: true
  validates :comment,     presence: true, length: { maximum: 255 }

  # Approves a comment.
  def approve(approved_by)
    update_columns(approved:       true,
                   approved_at:    Time.zone.now,
                   approved_by_id: approved_by.id)
  end
end