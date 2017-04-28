class DeleteUserData < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    transaction do
      Authentication::User.find_by(id: user_id)&.destroy
      Authorization::Admin.find_by(id: user_id)&.destroy
      Profiling::User.find_by(id: user_id)&.destroy
    end
  end
end
