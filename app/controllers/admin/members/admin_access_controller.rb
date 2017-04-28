module Admin
  module Members
    class AdminAccessController < Members::BaseController
      def create
        react_to ::Authorization::GrantAdminPermissions.(member.id)
      end

      def destroy
        react_to ::Authorization::TakeAwayAdminPermissions.(member.id)
      end

      private

      def default_redirect
        redirect_to admin_members_path
      end
    end
  end
end
