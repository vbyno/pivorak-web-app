module Admin
  class RegisterUser < ApplicationService
    PERMITTED_KEYS = %i[
      first_name
      last_name
      email
      synthetic
      verified
      cover
      admin
    ]

    attr_reader :params

    def initialize(params = {})
      @params = params.slice(*PERMITTED_KEYS)
    end

    def call
      transaction do
        user_id = Authentication::RegisterUser.(params.slice(:email, :synthetic)).id

        Profiling::SetProfileInfo.(user_id, params.slice(:email,
                                                         :first_name,
                                                         :last_name,
                                                         :verified,
                                                         :cover))

        Authorization::SetAdminPermissions.(user_id) if admin?
      end
    end

    private

    def admin?
      params[:admin]
    end
  end
end
