module Admin
  module Members
    class BaseController < Admin::BaseController
      helper_method :member

      private

      def member
        @member ||= Profiling::User.friendly.find(params[:member_id])
      end
    end
  end
end
