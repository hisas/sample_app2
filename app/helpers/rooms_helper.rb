module RoomsHelper
  def room_name(room)
    if room.user_id == current_user.id
      User.find(room.other_user_id).nickname
    else
      User.find(room.user_id).nickname
    end
  end
end
