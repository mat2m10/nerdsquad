class CpiecesController < ApplicationController
  before_action :set_clone, only: %i[update]

  def update
    @cpiece = Cpiece.find(params[:id])
    @cpiece.update!(cpiece_params)
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def cpiece_params
    params.require(:cpiece).permit(:name, :posX, :posY, :photo)
  end
end
