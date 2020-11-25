class GameroomsController < ApplicationController
  before_action :set_gameroom, only: %i[index show update]
  before_action :set_game, only: %i[index]
  def index
    @clone = @gameroom.clone
    @clones = Clone.all
  end

  def new
    @gameroom = Gameroom.new
    @gameroom.save
    redirect_to @gameroom
  end

  def create
    @gameroom = Gameroom.new(gameroom_params)
  end

  def show
    @clone = @gameroom.clone
    @game = @clone.game
    @message = Message.new
  end

  def update
    @gameroom.update(gameroom_params)
    redirect_to @gameroom
  end

  private

  def gameroom_params
    params.require(:gameroom).permit(:name)
  end

  def set_gameroom
    @gameroom = Gameroom.find(params[:id])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
