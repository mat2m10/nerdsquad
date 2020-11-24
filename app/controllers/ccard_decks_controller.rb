class CcardDecksController < ApplicationController
  before_action :set_clone, only: %i[update]
  before_action :set_ccard_deck, only: %i[update]

  def update
    @ccard_deck.update!(ccard_deck_params)
    redirect_to request.referrer
  end

  def draw!(deck, number)
    temp = CardDeck.new(game: @game, name: 'temp')
    drawn_cards = deck.cards.pop(number)
    drawn_cards.each do |card|
      card.deck = temp
    end
    temp.save
  end

  def shuffle!(ccard_deck)
    ccard_deck.ccards.each do |ccard|
      range = Range.new(0...@ccard_deck.ccards.size)
      ccard.update position: range.to_a.sample
    end
    flash.now "Deck shuffled!"
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
