class BoardsController < ApplicationController
  def new
    @board = Board.new
    @game = Game.find(params[:game_id])
  end

  def create
    @game = Game.find(params[:game_id])
    @board = Board.new(board_params)
    @board.game = @game
    if @board.save
      redirect_to game_board_path(params[:game_id],@board.id)
    else
      render 'games/new'
    end
  end

  def show
    @board = Board.find(params[:id])
    @game = Game.find(params[:game_id])
  end

  def update
    @board = Board.find(params[:id])
    @board.update!(board_params)
    if @board.game.gamerooms.last
      binding.pry
      GameroomChannel.broadcast_to(
        @board.game.gamerooms.last,
        "moved"
      )
    else
      redirect_to game_path(params[:game_id])
    end
    if @board.game.gamerooms.last
      redirect_back(fallback_location: gameroom_path(@board.game.gamerooms.last))
    end
  end

  private

  def board_params
    params.require(:board).permit(:photo, :posX, :posY)
  end
end


