module Authorization
  class Admin < ApplicationRecord
    self.table_name = :authorization_admins

    validates :id, presence: true
  end
end
