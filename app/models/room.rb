class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  def room_exists?
    Room.where(user_id: user_id, other_user_id: other_user_id).or(Room.where(user_id: other_user_id, other_user_id: user_id)).exists?
  end
end
