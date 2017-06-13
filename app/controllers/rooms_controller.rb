class RoomsController < ApplicationController
  before_action :set_room, only: :show

  def index
    @rooms = Room.where(user_id: current_user.id).or(Room.where(other_user_id: current_user.id))
  end

  def new
    @room = Room.new
  end

  def create
    @other_user = User.find_by(nickname: params[:room][:other_user_id])

    if @other_user == nil || @other_user.id == current_user.id
      flash[:danger] = "User not found"
      return redirect_to new_room_path
    else
      @room = current_user.rooms.build(other_user_id: @other_user.id)
    end

    unless @room.room_exists?
      if @room.save
        flash[:success] = "Room added!"
        redirect_to rooms_path
      else
        flash[:danger] = "Add room failed!"
        redirect_to new_room_path
      end
    else
      flash[:danger] = "Room has aleady created!"
      redirect_to new_room_path
    end
  end

  def show
    @message = Message.new
  end

  def set_room
    @room = Room.includes(:messages).find(params[:id])
    if @room.user_id != current_user.id && @room.other_user_id != current_user.id
      flash[:danger] = "You cannot access!"
      redirect_to rooms_path
    end
  end
end
