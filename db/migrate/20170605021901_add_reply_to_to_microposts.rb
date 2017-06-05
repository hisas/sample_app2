class AddReplyToToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :reply_to, :string
  end
end
