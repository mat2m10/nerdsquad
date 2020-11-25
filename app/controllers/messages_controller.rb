class MessagesController < ApplicationController
  before_action :set_clone, only: %i[create]
  before_action :set_gameroom, only: %i[create]

  def create
    @message = Message.new(message_params)
    @message.gameroom = @gameroom
    @message.user = current_user
    if @message.save
      GameroomChannel.broadcast_to(@gameroom, { message: render_to_string(partial: "message", locals: { message: @message }) })
      redirect_to gameroom_path(@gameroom, anchor: "message-#{@message.id}")
    else
      render "gamerooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_gameroom
    @gameroom = Gameroom.find(params[:gameroom_id])
  end

  def set_clone
    @clone = Gameroom.find(params[:gameroom_id]).clone
  end
end
