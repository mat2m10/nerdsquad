class PiecesController < ApplicationController
  before_action :set_game, only: %i[new create show]
  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
    @piece.game = @game
    if @piece.save
      flash[:success] = "Piece successfully created"
      redirect_to game_path(@game)
    else
      flash[:error] = "Something went wrong"
      redirect_to @piece
    end
  end

  def show
    @piece = Piece.find(params[:id])
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def piece_params
    params.require(:piece).permit(:photo, :name, :posX, :posY)
  end
end
