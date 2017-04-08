# handlers/profiling/user_registration_handler.rb
module Profiling
  module UserRegistrationHandler
    def self.call(name, started, finished, unique_id, payload)
      User.create(
        id:         payload.fetch(:user_id),
        first_name: payload.fetch(:first_name),
        last_name:  payload.fetch(:last_name),
        email:      payload.fetch(:email)
      )
    end
  end
end

