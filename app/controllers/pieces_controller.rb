class PiecesController < ApplicationController
  before_action :set_game, only: %i[new create show edit update]
  before_action :set_piece, only: %i[show edit update]
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
  end

  def edit
  end

  def update
    if @piece.update_attributes(piece_params)
      flash[:success] = "Piece was successfully updated"
      redirect_to @game
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:photo, :name, :posX, :posY)
  end
end
