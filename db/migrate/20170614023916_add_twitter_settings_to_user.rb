class AddTwitterSettingsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :twitter_uid, :string
    add_column :users, :twitter_image_url, :string
  end
end
