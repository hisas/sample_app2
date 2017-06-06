class AddReplyMicropostToMicropost < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :reply_micropost, :integer
  end
end
