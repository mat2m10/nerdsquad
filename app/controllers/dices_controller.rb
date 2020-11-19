class DicesController < ApplicationController
  before_action :set_game, only: %i[new create show]

  def new
    @dice = Dice.new
    @game = Game.find(params[:game_id])
  end

  def create
    number_of_dices = params[:dices][:number_of_dices].to_i
    # number_of_faces = params[:faces][:number_of_faces].to_i
    @game = Game.find(params[:game_id])
    number_of_dices.times do      
    @dice = Dice.new(dice_params)
    @dice.game = @game
    if @dice.save
      flash[:success] = "Dice successfully created"
      redirect_to game_path(@game)
    else
      flash[:error] = "Something went wrong"
      render 'new'
      end
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
