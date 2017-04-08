class Identity < ApplicationRecord
  belongs_to :user, class_name: 'Authentication::User'

  validates :uid, :provider, presence: true
  validates :user_id, presence: true
end
