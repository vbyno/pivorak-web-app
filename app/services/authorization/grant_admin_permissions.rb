module Authorization
  module GrantAdminPermissions
    def self.call(admin_id)
      Admin.where(id: admin_id).first_or_create
    end
  end
end
