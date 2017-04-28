module Profiling
  module UserEmailChangedHandler
    def self.call(name, started, finished, unique_id, payload)
      User.find(payload.fetch(:user_id)).update_attributes(email: payload.fetch(:email))
    end
  end
end
