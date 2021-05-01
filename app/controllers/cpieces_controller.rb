class CpiecesController < ApplicationController
  before_action :set_clone, only: %i[update]
  before_action :set_cpiece, only: %i[update]

  def update
    @cpiece.update!(cpiece_params)
    GameroomChannel.broadcast_to(@clone.gameroom, "moved")
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_cpiece
    @cpiece = Cpiece.find(params[:id])
  end

  def cpiece_params
    params.require(:cpiece).permit(:name, :posX, :posY, :photo)
  end
end



