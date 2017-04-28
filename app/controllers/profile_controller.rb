class ProfileController < ApplicationController
  disabled_feature_until '1.1'

  before_action :authenticate_user!

  helper_method :profiling_user

  def update
    if UpdateUserData.call(profiling_user, profiling_user_params)
      flash[:notice] = t('notifications.success')
      redirect_to root_path
    else
      flash[:error] = t('notifications.failure')
      render :edit
    end
  end

  private

  def profiling_user
    @profiling_user ||= Profiling::User.find(current_user_id)
  end

  def profiling_user_params
    params.require(:profiling_user).permit(:first_name, :last_name, :cover)
  end
end
