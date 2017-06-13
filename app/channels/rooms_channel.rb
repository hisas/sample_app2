class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_#{params['room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    message = current_user.messages.create!(content: data["message"], room_id: data["room_id"])
    MessageBroadcastJob.perform_later(message)
  end
end
