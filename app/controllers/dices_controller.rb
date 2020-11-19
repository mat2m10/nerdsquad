class DicesController < ApplicationController
  before_action :set_game, only: %i[new create show]

  def new
    @dice = Dice.new
  end

  def create
    @game = Game.find(params[:game_id])
    @dice = Dice.new(dice_params)
    @dice.game = @game
    @dice.save
    redirect_to game_path(@game)
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def dice_params
    params.require(:dice).permit(:faces, :posX, :posY)
  end
end
