module Authorization
  def self.admins_id?(id)
    Authorization::Admin.exists?(id: id)
  end
end
