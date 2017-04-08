class Donation < ApplicationRecord
  belongs_to :user, class_name: 'Profiling::User'
  belongs_to :goal

  validates :amount, presence: true, numericality: true
  validates :payment_id, uniqueness: true, presence: true
end
