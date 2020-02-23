class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    Seek.create(current_user)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    Seek.remove(current_user)
  end
end
