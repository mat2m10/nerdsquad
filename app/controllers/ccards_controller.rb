class CcardsController < ApplicationController
  before_action :set_clone, only: %i[update]
  before_action -> { require_player!(@clone.gameroom) }, only: %i[update]
  before_action :set_deck, only: %i[update]
  before_action :set_card, only: %i[update]

  def update
    @ccard.update!(ccard_params)
    return unless @ccard.ccard_deck.game_clone.gameroom

    GameroomChannel.broadcast_to(@ccard.ccard_deck.game_clone.gameroom, "moved")
    redirect_to request.referrer
  end

  private

  def set_clone
    @clone = Clone.find(params[:clone_id])
  end

  def set_deck
    @ccard_deck = @clone.ccard_decks.find(params[:ccard_deck_id])
  end

  def set_card
    @ccard = @ccard_deck.ccards.find(params[:id])
  end

  def ccard_params
    params.require(:ccard).permit(:name, :posX, :posY, :photo, :position, :visible)
  end
end



