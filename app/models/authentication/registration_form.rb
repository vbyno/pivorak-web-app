module Authentication
  class RegistrationForm
    include ActiveModel::Model
    include ActiveModel::AttributeAssignment

    LATIN_LETTERS_REGEX = /[a-zA-Z]+/

    attr_accessor :email,
                  :first_name,
                  :last_name,
                  :password,
                  :password_confirmation

    validates :first_name, :last_name, presence: true, format: {
      with: LATIN_LETTERS_REGEX, message: I18n.t('errors.only_latin_letters')
    }

    delegate :persisted?, :authenticatable_salt, to: :user

    def self.model_name
      ActiveModel::Name.new(self, nil, 'Authentication::User')
    end

    def save
      return false unless valid?

      errors.merge!(user.errors) and return false unless user.save

      ActiveSupport::Notifications.instrument('user_registered', user_id: user_id,
                                                                 email: email,
                                                                 first_name: first_name,
                                                                 last_name: last_name)
      user
    end

    def active_for_authentication?
      true
    end

    private

    def user
      @user ||= User.new(
        id: user_id,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )
    end

    def user_id
      @user_id ||= SecureRandom.uuid
    end
  end
end
