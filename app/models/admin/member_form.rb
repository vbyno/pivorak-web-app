module Admin
  class MemberForm
    include ActiveModel::Model
    include ActiveModel::AttributeAssignment

    attr_accessor :email,
                  :first_name,
                  :last_name,
                  :verified,
                  :cover,
                  :admin

    def self.model_name
      ActiveModel::Name.new(self, nil, 'Member')
    end
  end
end
