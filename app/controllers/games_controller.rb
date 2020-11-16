class GamesController < ApplicationController
  def new
    @game = Game.new
  end
  def create
    @game = Game.new(game_params)
    @user = current_user
    @board = Board.new
    @dice = Dice.new
    @token = Token.new
    @game.board = @board
    @game.dices = @dices
    @game.pieces = @pieces
    @game.tokens = @tokens
    @game.user = @user
    if @game.save
      redirect_to root_path
    else
      raise
    end
  end

  private

  def game_params
    params.require(:game).permit(:number_of_players)
  end
end
