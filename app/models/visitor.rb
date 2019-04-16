class Visitor < ApplicationRecord

  validates :remote_ip, presence: true, uniqueness: true

  def self.visitors_count
    Rails.cache.fetch("visitors_count") do
      count
    end
  end
end
