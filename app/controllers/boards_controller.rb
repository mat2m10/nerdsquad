class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @game = Game.find(params[:game_id])
    @board = Board.new(board_params)
    @board.game = @game
    @board.save
    if @board.save 
      redirect_to @game
    else
      render 'games/new'
    end
  end

  private

  def board_params
    params.require(:board).permit(:photo)
  end
end
