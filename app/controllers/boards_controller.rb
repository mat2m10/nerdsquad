class BoardsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @user = current_user
    @board = Board.new(board_params)
    @board.user = @user
    @board.game = @game
    redirect_to game_path(@game)
  end

  private

  def board_params
    params.require(:board).permit(:)
  end
end
