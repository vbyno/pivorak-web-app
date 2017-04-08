module Admin
  class GatheredMembersController < BaseController
    helper_method :members, :admin_members_list
    add_breadcrumb 'members.plural', :admin_members_path

    private

    def members
      @members ||= search_against(User).order(:created_at).page(params[:page])
    end

    def admin_members_list
      @admin_members_list ||= User.admin
    end
  end
end
