class AddUuidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_id, :uuid, null: false, default: 'uuid_generate_v4()'
  end
end
