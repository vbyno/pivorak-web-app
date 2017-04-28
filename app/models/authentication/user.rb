module Authentication
  class User < ApplicationRecord
    self.table_name = :authentication_users

    devise :database_authenticatable, :registerable, :confirmable,
           :recoverable, :rememberable, :trackable,
           :validatable, :omniauthable, omniauth_providers: Devise.omniauth_providers

    has_many :identities, foreign_key: :user_id, dependent: :destroy

    validates :id, presence: true

    # for sending emails in background
    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
