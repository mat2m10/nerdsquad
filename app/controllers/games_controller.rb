class GamesController < ApplicationController
  def new
    @game = Game.new
    @game.user = current_user
    @board = Board.new
    @dice = Dice.new
    @piece = Piece.new
    @token = Token.new
  end

  def create
    @game = Game.new(game_params)
    @user = current_user
    @board = Board.new
    @game.user = @user
    @game.save
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
    @board = Board.new
    @dice = Dice.new
  end

  def preview
    @game = Game.find(params[:game_id])
  end

  private

  def game_params
    params.require(:game).permit(:number_of_players)
  end
end
