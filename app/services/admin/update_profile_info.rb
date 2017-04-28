module Admin
  class UpdateProfileInfo < ApplicationService
    attr_reader :user_id, :params

    def initialize(user_id, params)
      @user_id = user_id
      @params = params
    end

    def call
      return unless user

      user.update(params)
    end

    private

    def user
      @user ||= Profiling::User.find(user_id)
    end
  end
end
