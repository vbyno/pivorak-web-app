class UpdateUserData < UserBase
  def self.call(profiling_user, params)
    profiling_user.update(params)
  end
end
