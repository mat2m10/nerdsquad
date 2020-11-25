class DicesController < ApplicationController
  before_action :set_game, only: %i[new create]

  def new
    @dice = Dice.new
  end

  def create
    number_of_dices = params[:dice][:number_of_dices].to_i
    # number_of_faces = params[:faces][:number_of_faces].to_i
    number_of_dices.times do
      dice = Dice.new(dice_params)
      dice.game = @game
      dice.save
    end
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
