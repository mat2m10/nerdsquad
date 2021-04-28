class CtokensController < ApplicationController
  before_action :set_clone, only: %i[update]
  before_action :set_ctoken, only: %i[update]

  def update
    @ctoken.update!(ctoken_params)
    GameroomChannel.broadcast_to(@clone.gameroom, "moved")
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_ctoken
    @ctoken = Ctoken.find(params[:id])
  end

  def ctoken_params
    params.require(:ctoken).permit(:name, :posX, :posY, :photo, :number_of_tokens)
  end
end



