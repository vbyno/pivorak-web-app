class ChangeVisitRequestsUserIdColumnType < ActiveRecord::Migration[5.0]
  def up
    add_column :visit_requests, :user_id_temp, :uuid

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE visit_requests
      SET user_id_temp = users.user_id
      FROM visit_requests as vr
        INNER JOIN users ON vr.user_id = users.id
    SQL

    remove_column :visit_requests, :user_id
    rename_column :visit_requests, :user_id_temp, :user_id
    change_column :visit_requests, :user_id, :uuid, null: false

    add_index :visit_requests, :user_id
  end

  def down
    add_column :visit_requests, :user_id_temp, :integer

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE visit_requests
      SET user_id_temp = users.id
      FROM visit_requests as vr
        INNER JOIN users ON vr.user_id = users.user_id
    SQL

    remove_column :visit_requests, :user_id
    rename_column :visit_requests, :user_id_temp, :user_id
  end
end
