class AuthorizationCreateAdminsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :authorization_admins, id: :uuid do |t|
      t.datetime :created_at, null: false
    end
  end
end
