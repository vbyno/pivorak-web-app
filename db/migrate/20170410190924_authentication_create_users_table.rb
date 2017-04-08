class AuthenticationCreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :authentication_users, id: :uuid do |t|
      t.string   :email,                  default: '', null: false
      t.string   :encrypted_password,     default: '', null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count,          default: 0,  null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at

      t.timestamps

      t.index :email, unique: true
      t.index :confirmation_token, unique: true
      t.index :reset_password_token, unique: true
    end
  end
end
