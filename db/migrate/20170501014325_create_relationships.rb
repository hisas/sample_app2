class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps
    end
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
