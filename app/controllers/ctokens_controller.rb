class CtokensController < ApplicationController
  before_action :set_clone, only: %i[update]

  def update
    @ctoken = Ctoken.find(params[:id])
    @ctoken.update!(ctoken_params)
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def ctoken_params
    params.require(:ctoken).permit(:name, :posX, :posY, :photo, :number_of_tokens)
  end
end
