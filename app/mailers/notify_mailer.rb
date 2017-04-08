class NotifyMailer < ApplicationMailer
  def become_speaker(params)
    name = params[:name]
    email = params[:email]
    text = params[:text]

    mail(from: "#{name} <#{email}>",
         subject: I18n.t('mailers.notify_mailer.become_speaker.subject'),
         to: PIVORAK_EMAIL) do |format|
      format.html { text }
    end
  end

  def new_user_registered(full_name:, email:)
    mail(from: NO_REPLY_EMAIL ,
         subject: I18n.t('mailers.notify_mailer.new_user_registered.subject', user: full_name),
         to: PIVORAK_EMAIL) do |format|
      format.html { I18n.t('mailers.notify_mailer.new_user_registered.body', user: full_name, email: email) }
    end
  end
end
