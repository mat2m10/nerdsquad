class ClonesController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @clone = Clone.new(game_id: @game.id)
    @clone.name = @game.name
    @clone.board = @game.board
    @clone.description = @game.description
    @clone.save
    redirect_to game_clone_path(@game, @clone)
  end

  def show
    @clone = Clone.find(params[:id])
  end

  def create; end

  private

  def clone_params
    params.require(:clone).permit(:name)
  end
end
