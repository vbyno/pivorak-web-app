module Authentication
  class User
    class Register < ApplicationService
      def initialize(email:, password:, **profiling_params)
        @email = email
        @password = password
        @profiling_params = profiling_params
      end

      def call
        transaction do
          id = SecureRandom.uuid

          user = User.create(id: id, email: email, password: password)

          ::Profiling::User.create(profiling_params.merge(email: email, id: id)) if user.persisted?

          user
        end
      end

      private

      attr_reader :email, :password, :profiling_params
    end
  end
end
