class DicesController < ApplicationController
  before_action :set_game, only: %i[new create update]
  before_action :set_dice, only: %i[show update]
  def new
    @dice = Dice.new
  end

  def create
    number_of_dices = params[:dice][:number_of_dices].to_i
    number_of_dices.times do
      @dice = Dice.new(dice_params)
      @dice.game = @game
      @dice.save
    end
    redirect_to game_dice_path(@game, @dice)
  end

  def update
    @dice.update(dice_params)
    redirect_to request.referrer and return unless request.referrer.include? 'dices'

    num = @dice.number_of_dices
    @game.dices[-num..].each do |dice|
      dice.assign_attributes(posX: @dice.posX + num * 100, posY: @dice.posY + num * 100)
      num -= 1
      dice.save
    end
    redirect_to request.referrer
  end

  def show; end

  private

  def dice_params
    params.require(:dice).permit(:faces, :posX, :posY, :photo, :number_of_dices, :value)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_dice
    @dice = Dice.find(params[:id])
  end
end
