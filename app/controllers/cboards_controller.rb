class CboardsController < ApplicationController
  before_action :set_clone, only: :update
  before_action -> { require_player!(@clone.gameroom) }, only: :update
  before_action :set_cboard, only: :update

  def update
    @cboard.update!(cboard_params)
    return unless @cboard.game_clone.gameroom

    GameroomChannel.broadcast_to(@cboard.game_clone.gameroom, "moved")
    redirect_to request.referrer
    # redirect_back(fallback_location: gameroom_path(@cboard.game_clone.gameroom))
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_cboard
    @cboard = Cboard.where(game_clone: @clone).find(params[:id])
  end

  def cboard_params
    params.require(:cboard).permit(:name, :posX, :posY, :photo)
  end
end
