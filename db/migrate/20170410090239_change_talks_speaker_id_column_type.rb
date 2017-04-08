class ChangeTalksSpeakerIdColumnType < ActiveRecord::Migration[5.0]
  def up
    add_column :talks, :speaker_id_temp, :uuid

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE talks
      SET speaker_id_temp = users.user_id
      FROM talks as _talks
        INNER JOIN users ON _talks.speaker_id = users.id
    SQL

    remove_column :talks, :speaker_id
    rename_column :talks, :speaker_id_temp, :speaker_id

    add_index :talks, :speaker_id
  end

  def down
    add_column :talks, :speaker_id_temp, :integer

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE talks
      SET speaker_id_temp = users.id
      FROM talks as _talks
        INNER JOIN users ON _talks.speaker_id = users.user_id
    SQL

    remove_column :talks, :speaker_id
    rename_column :talks, :speaker_id_temp, :speaker_id
  end
end
