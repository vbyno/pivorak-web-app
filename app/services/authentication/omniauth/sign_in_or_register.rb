module Authentication
  module Omniauth
    class SignInOrRegister < ApplicationService
      attr_reader :email, :info, :provider, :uid

      def initialize(info: {}, provider: nil, uid: nil)
        @info = info
        @email = info[:email]
        @provider = provider&.to_sym
        @uid = uid
      end

      def call
        return unless email

        return user if user.persisted? && identity.persisted?
          # User.create(email: email, password: password).tap do |user|
          #   # ::Profiling::User.create(
          #   #   profiling_params.merge(email: email, id: user.id)
          #   # )
          # end
      end

      private

      def user
        @user ||=
          User.find_by(email: email) ||
          User::Register.(
            email: email,
            password: password,
            first_name: first_name,
            last_name: last_name
          )
      end

      def identity
        @identity ||= ::Identity.find_or_create_by(
          uid:      uid,
          provider: provider,
          user:     user
        )
      end

      def first_name
        name&.first
      end

      def last_name
        name&.last
      end

      def name
        @name ||= info[:name]&.split(' ')
      end

      def password
        Devise.friendly_token[0, 20]
      end
    end
  end
end
