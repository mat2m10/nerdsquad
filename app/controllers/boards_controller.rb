class BoardsController < ApplicationController
  before_action :set_game, only: %i[new create show update destroy]
  before_action :set_board, only: %i[show update destroy]

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.game = @game
        if @board.save
      redirect_to game_board_path(params[:game_id], @board.id)
    else
      render 'games/new'
    end
  end

  def show
  end

  def update
    @game.board = @board
    @board.update!(board_params)
    redirect_to request.referrer
  end

  def destroy
    if @board.destroy
      flash[:success] = 'Board was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @game
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def board_params
    params.require(:board).permit(:photo, :posX, :posY, :height, :width, :angle)
  end
end
