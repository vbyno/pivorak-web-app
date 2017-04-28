module Authentication
  module Omniauth
    class CallbacksController < ::Devise::OmniauthCallbacksController
      def handle_callback
        user = SignInOrRegister.call(omniauth_params)

        if user
          user.confirm
          flash[:success] = 'You have successfully logged in'
          sign_in_and_redirect(user)
        else
          flash[:alert] = 'User has invalid details. Please try other OAuth'
          redirect_to(new_user_session_path)
        end
      end

      Devise.omniauth_providers.each { |provider| alias_method provider, :handle_callback }

      private

      def omniauth_params
        request.env['omniauth.auth']
      end
    end
  end
end
