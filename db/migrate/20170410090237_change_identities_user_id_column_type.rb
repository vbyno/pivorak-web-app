class ChangeIdentitiesUserIdColumnType < ActiveRecord::Migration[5.0]
  def up
    add_column :identities, :user_id_temp, :uuid

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE identities
      SET user_id_temp = users.user_id
      FROM identities as _identities
        INNER JOIN users ON _identities.user_id = users.id
    SQL

    remove_column :identities, :user_id
    rename_column :identities, :user_id_temp, :user_id
    change_column :identities, :user_id, :uuid, null: false

    add_index :identities, :user_id
  end

  def down
    add_column :identities, :user_id_temp, :integer

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE identities
      SET user_id_temp = users.id
      FROM identities as _identities
        INNER JOIN users ON _identities.user_id = users.user_id
    SQL

    remove_column :identities, :user_id
    rename_column :identities, :user_id_temp, :user_id
  end
end
