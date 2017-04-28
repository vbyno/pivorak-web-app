module Authorization
  module TakeAwayAdminPermissions
    def self.call(admin_id)
      Admin.delete(admin_id)
    end
  end
end
