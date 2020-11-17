class PiecesController < ApplicationController
  def new
    @piece = Piece.new
  end

  def create
    @game = Game.find(params[:game_id])
    @piece = Piece.new(piece_params)
    @piece.game = @game
    @piece.save
    redirect_to game_path(@game)
  end

  private

  def piece_params
    params.require(:piece).permit(:photo)
  end
end
