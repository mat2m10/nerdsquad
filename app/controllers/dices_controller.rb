class DicesController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    @dice = Dice.create(game: @game)
  end

  def create
    @dice = Dice.find(params[:id])
    number_of_dices = @dice.number_of_dices.to_i
    number_of_dices.times do
      dice = Dice.new(dice_params)
      dice.game = @game
      dice.save
    end
    redirect_to game_dice_path
  end

  def update
    @game = Game.find(params[:game_id])
    @dice = @game.dices.last
    @dice.update(dice_params)
    redirect_to game_dice_path(@game, @dice)
  end

  def show
    @game = Game.find(params[:game_id])
  end

  private

  def dice_params
    params.require(:dice).permit(:faces, :posX, :posY, :photo, :number_of_dices)
  end
end
