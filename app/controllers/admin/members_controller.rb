module Admin
  class MembersController < BaseController
    helper_method :member, :url
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @member = MemberForm.new

      render_form
    end

    def create
      @member = RegisterMember.call(users_params)

      react_to member
    end

    def update
      react_to UpdateProfileInfo.(member.id, users_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_member_path(member)
    end

    def member
      @member ||= Profiling::User.friendly.find(params[:id])
    end

    def users_params
      params.require(:member).permit(:email, :first_name, :last_name, :verified, :cover)
    end

    def url
      member.persisted? ? admin_member_path(member) : admin_members_path
    end
  end
end
