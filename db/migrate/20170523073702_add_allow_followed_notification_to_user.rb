class AddAllowFollowedNotificationToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :allow_followed_notification, :boolean, default: false, null: false
  end
end
