class CcardDecksController < ApplicationController
  before_action :set_clone, only: %i[update]
  before_action :set_ccard_deck, only: %i[update]

  def update
    @ccard_deck.update!(ccard_deck_params)
    if @clone.gameroom
      GameroomChannel.broadcast_to(
        @clone.gameroom,
        "moved"
      )
    end
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_ccard_deck
    @ccard_deck = CcardDeck.find(params[:id])
  end

  def ccard_deck_params
    params.require(:ccard_deck).permit(:name, :posX, :posY)
  end
end
