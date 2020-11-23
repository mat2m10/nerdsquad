class CcardDecksController < ApplicationController
  before_action :set_clone, only: %i[update]

  def update
    @ccard_deck = CcardDeck.find(params[:id])
    @ccard_deck.update!(ccard_deck_params)
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def ccard_deck_params
    params.require(:ccard_deck).permit(:name, :posX, :posY)
  end
end
