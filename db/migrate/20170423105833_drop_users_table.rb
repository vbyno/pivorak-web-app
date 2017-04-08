class DropUsersTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string   :email,                  default: "",                          null: false
      t.string   :encrypted_password,     default: "",                          null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count,          default: 0,                           null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.datetime :created_at,                                                   null: false
      t.datetime :updated_at,                                                   null: false
      t.boolean  :admin,                  default: false
      t.string   :first_name
      t.string   :last_name
      t.boolean  :synthetic,              default: false
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :slug
      t.boolean  :verified,               default: false
      t.string   :cover
      t.uuid     :user_id,                default: -> { "uuid_generate_v4()" }, null: false

      t.index :confirmation_token, unique: true
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
      t.index :slug
    end
  end
end
