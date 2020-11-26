class CdicesController < ApplicationController
  before_action :set_dice, only: %i[update]
  before_action :set_clone, only: %i[update]
  def update
    @cdice.update!(cdice_params)
    return unless @cdice.clone.gameroom
    GameroomChannel.broadcast_to(@cdice.clone.gameroom, "moved")
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_dice
    @cdice = Cdice.find(params[:id])
  end

  def cdice_params
    params.require(:cdice).permit(:name, :posX, :posY, :photo, :value, :faces, :angle, :width, :height)
  end
end
