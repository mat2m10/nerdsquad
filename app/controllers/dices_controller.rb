class DicesController < ApplicationController
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

  def dice_params
    params.require(:dice).permit(:faces, :posX, :posY)
  end
end
