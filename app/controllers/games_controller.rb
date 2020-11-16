class GamesController < ApplicationController
  def new
    @game = Game.new
    @board = Board.new
    @dice = Dice.new
    @piece = Piece.new
    @token = Token.new
  end

  def create
    @game = Game.new(game_params)
    @user = current_user
    @board = Board.new
    @dice = Dice.new
    @token = Token.new
    @game.board = @board
    @game.dice = @dice
    @game.piece = @piece
    @game.token = @token
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
