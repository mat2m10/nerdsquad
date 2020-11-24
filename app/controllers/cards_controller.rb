class CardsController < ApplicationController
  before_action :set_game, only: %i[new create update destroy]
  before_action :set_card_deck, only: %i[new create show update destroy]
  before_action :set_card, only: %i[destroy]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.card_deck = @card_deck
    @card.position = @card_deck.cards.count + 1
    @card.posX = @card_deck.posX
    @card.posY = @card_deck.posY + @card.position * 40
    if @card.save && @card_deck.cards.count > 1
      redirect_to @game
    else
      redirect_to game_card_deck_path(@game, @card_deck)
    end
  end

  def update
    @card.update!(card_params)
  end

  def show; end

  def destroy
    @card.destroy
    @card_deck.destroy if @card_deck.cards.empty?
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_card_deck
    @card_deck = CardDeck.find(params[:card_deck_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:photo, :name, :position, :posX, :posY)
  end
end
