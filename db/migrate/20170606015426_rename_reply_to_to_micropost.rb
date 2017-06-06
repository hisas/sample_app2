class RenameReplyToToMicropost < ActiveRecord::Migration[5.1]
  def change
    rename_column :microposts, :reply_to, :reply_nickname
  end
end
