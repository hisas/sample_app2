class AddOtherUserIdToRooms < ActiveRecord::Migration[5.1]
  def up
    add_column :rooms, :other_user_id, :integer
    change_column :rooms, :other_user_id, :integer, null: false
  end

  def down
    remove_column :rooms, :other_user_id
  end
end
