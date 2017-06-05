class AddNicknameToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :nickname, :string
    change_column :users, :nickname, :string, null: false
    add_index :users, :nickname, unique: true
  end

  def down
    remove_column :users, :nickname
  end
end
