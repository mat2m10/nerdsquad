class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @game = Game.find(params[:game_id])
    @user = current_user
    @board = Board.new(board_params)
    @board.user = @user
    @board.game = @game
    @board.save
    redirect_to game_path(@game)
  end

  private

  def board_params
    params.require(:board).permit(:photo)
  end
end
