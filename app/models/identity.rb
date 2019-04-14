class Identity < ApplicationRecord
  belongs_to :user

  validates :user_id,  presence: true
  validates :uid,      presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true

  def self.find_or_create_with_omniauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_initialize do |identity|
      identity.user     = User.find_or_create_with_omniauth(auth)
      identity.uid      = auth.uid
      identity.provider = auth.provider
      identity.save!
    end
  end
end
