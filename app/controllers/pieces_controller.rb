class PiecesController < ApplicationController
  before_action :set_game, only: %i[new create show edit update destroy]
  before_action :set_piece, only: %i[show edit update destroy]
  def new
    @piece = Piece.new
  end

  def create
    (redirect_to request.referrer, alert: 'Join a picture' and return) if params[:piece][:photo].nil?

    @piece = Piece.new(piece_params)
    @piece.game = @game
    @piece.save ? (redirect_to game_piece_path(@game, @piece) and return) : (redirect_to @piece and return)
    
  end

  def show
  end

  def edit
  end

  def update
    @piece.update!(piece_params)
    redirect_to request.referrer
  end

  def destroy
    if @piece.destroy
      flash[:success] = 'Piece was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:photo, :name, :posX, :posY, :height, :width, :angle)
  end
  
end
