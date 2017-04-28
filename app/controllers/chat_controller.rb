class ChatController < ApplicationController
  disabled_feature_until '1.3'

  helper_method :current_user_email

  def create
    if Chat::Invite.call(params[:email])
      flash[:notice] = I18n.t('chat.success', email: params[:email])
    else
      flash[:error] = I18n.t('chat.email_required')
    end

  rescue Chat::Client::ChatError => error
    flash[:error] = I18n.t(error, scope: 'chat.errors')

  ensure
    redirect_to chat_path
  end

  private

  def current_user_email
    return @current_user_email if defined?(@current_user_email)

    @current_user_email = Profiling::User.find_by(id: current_user_id)&.email
  end
end
