module Authentication
  class RegistrationsController < Devise::RegistrationsController
    protected

    def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end

    def build_resource(hash = {})
      self.resource = RegistrationForm.new(hash)
    end

    def update_resource(resource, params)
      super.tap do |result|
        if result && params.has_key?(:email)
          ActiveSupport::Notifications.instrument(
            'user_email_changed', user_id: resource.id,
                                  email: params.fetch(:email)
          )
        end
      end
    end

    def after_sign_up_path_for(resource)
      root_path
    end
  end
end
