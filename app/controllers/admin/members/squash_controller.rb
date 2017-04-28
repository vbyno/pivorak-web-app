module Admin
  module Members
    class SquashController < Members::BaseController
      add_breadcrumb 'members.plural', :admin_members_path

      helper_method :header_title, :squash_into_users

      def show
        add_breadcrumb 'words.squash'
      end

      def create
        react_to SquashUser.call(
          squashed_user_id: member.id,
          into_user_id:     params.fetch(:into_user)
        )
      end

      private

      def default_redirect
        redirect_to admin_members_path
      end

      def header_title
        t 'members.plural'
      end

      def squash_into_users
        @squash_into_users ||= Profiling::User.where.not(id: member.id)
      end
    end
  end
end
