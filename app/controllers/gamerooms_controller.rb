class GameroomsController < ApplicationController
  def new
    @gameroom = Gameroom.new
  end

  def create
    @game = Game.find(params[:game_id])
    @clone = Clone.find(params[:clone_id])
    @gameroom = Gameroom.new(gameroom_params)
    @gameroom.save
  end

  def show
    @game = Game.find(params[:game_id])
    @gameroom = Gameroom.find(params[:id])
    @clone = @gameroom.clone
    @message = Message.new
  end

  def update
    @gameroom = Gameroom.find(params[:id])
    @gameroom.update(gameroom_params)
    redirect_to gameroom_path(params[:id])
  end

  private

  def gameroom_params
    params.require(:gameroom).permit(:name, :game, :clone)
  end
end
