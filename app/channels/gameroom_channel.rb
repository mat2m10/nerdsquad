class GameroomChannel < ApplicationCable::Channel
  def subscribed
    # Only players who joined the room may follow its moves and chat.
    gameroom = Gameroom.find_by(id: params[:id])
    return reject unless gameroom&.users&.exists?(current_user.id)

    stream_for gameroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
