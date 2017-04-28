class ProfilingCreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :profiling_users, id: :uuid do |t|
      t.string  :email,      null: false
      t.string  :first_name, null: false
      t.string  :last_name,  null: false
      t.boolean :verified,   null: false, default: false
      t.string  :slug
      t.string  :cover

      t.timestamps
    end
  end
end
