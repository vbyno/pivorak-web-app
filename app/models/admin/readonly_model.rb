module Admin
  module ReadonlyModel
    def readonly?
      true
    end

    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
  end
end
