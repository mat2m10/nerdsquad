class CboardsController < ApplicationController
  before_action :set_clone, only: :update
  before_action :set_cboard, only: :update

  def update
    @cboard.update!(cboard_params)
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_cboard
    @cboard = Cboard.find(params[:id])
  end

  def cboard_params
    params.require(:cboard).permit(:name, :posX, :posY, :photo)
  end
end
