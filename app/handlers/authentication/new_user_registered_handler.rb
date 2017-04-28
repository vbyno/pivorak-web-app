module Authentication
  module NewUserRegisteredHandler
    def self.call(name, started, finished, unique_id, payload)
      NotifyMailer.new_user_registered(
        full_name: payload.values_at(:first_name, :last_name).join(' '),
        email: payload.fetch(:email)
      ).deliver_later
    end
  end
end


