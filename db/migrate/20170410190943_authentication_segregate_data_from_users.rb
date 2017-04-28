class AuthenticationSegregateDataFromUsers < ActiveRecord::Migration[5.0]
  class AuthenticationUser < ActiveRecord::Base;
    self.table_name = :authentication_users
  end

  def up
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO authentication_users (
        id,
        email,
        encrypted_password,
        reset_password_token,
        reset_password_sent_at,
        remember_created_at,
        sign_in_count,
        current_sign_in_at,
        last_sign_in_at,
        current_sign_in_ip,
        last_sign_in_ip,
        confirmation_token,
        confirmed_at,
        confirmation_sent_at,
        created_at,
        updated_at
      )
      SELECT
        user_id,
        email,
        encrypted_password,
        reset_password_token,
        reset_password_sent_at,
        remember_created_at,
        sign_in_count,
        current_sign_in_at,
        last_sign_in_at,
        current_sign_in_ip,
        last_sign_in_ip,
        confirmation_token,
        confirmed_at,
        confirmation_sent_at,
        created_at,
        updated_at
      FROM users as _users
        WHERE _users.synthetic is FALSE
    SQL
  end

  def down
    AuthenticationUser.delete_all
  end
end
