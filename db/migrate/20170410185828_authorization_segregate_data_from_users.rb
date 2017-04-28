class AuthorizationSegregateDataFromUsers < ActiveRecord::Migration[5.0]
  class AuthorizationAdmin < ActiveRecord::Base;
    self.table_name = :authorization_admins
  end

  def up
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO authorization_admins (
        id,
        created_at
      )
      SELECT
        user_id,
        created_at
      FROM users
        WHERE admin is TRUE
    SQL
  end

  def down
    AuthorizationAdmin.delete_all
  end
end
