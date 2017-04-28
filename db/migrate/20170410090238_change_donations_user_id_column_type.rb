class ChangeDonationsUserIdColumnType < ActiveRecord::Migration[5.0]
  def up
    add_column :donations, :user_id_temp, :uuid

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE donations
      SET user_id_temp = users.user_id
      FROM donations as _donations
        INNER JOIN users ON _donations.user_id = users.id
    SQL

    remove_column :donations, :user_id
    rename_column :donations, :user_id_temp, :user_id

    add_index :donations, :user_id
  end

  def down
    add_column :donations, :user_id_temp, :integer

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE donations
      SET user_id_temp = users.id
      FROM donations as _donations
        INNER JOIN users ON _donations.user_id = users.user_id
    SQL

    remove_column :donations, :user_id
    rename_column :donations, :user_id_temp, :user_id
  end
end
