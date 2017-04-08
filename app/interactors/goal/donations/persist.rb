class Goal < ApplicationRecord
  module Donations
    class Persist
      include Interactor

      delegate :user_id, :goal, :amount, to: :context
      delegate :donations,               to: :goal

      def call
        context.donation = donations.create(amount: amount, user_id: user_id)
      end
    end
  end
end
