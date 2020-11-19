class CardDecksController < ApplicationController
  before_action :set_game, only: %i[new create edit update shuffle! draw show]
  before_action :find_deck, only: %i[show]

  def new
    @card_deck = CardDeck.new
  end

  def create
    @card_deck = CardDeck.new(card_deck_params)
    @card_deck.game = @game
    if @card_deck.save
      flash[:success] = "Card deck successfully created"
      redirect_to new_game_card_deck_card_path(@game, @card_deck)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def show; end

  def update
    @card_deck = CardDeck.find(params[:id])
    if @card_deck.update_attributes(card_deck_params)
      flash[:success] = "Deck was successfully updated"
      redirect_to @game
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def edit; end

  def draw!(deck, number)
    temp = CardDeck.new(game: @game, name: 'temp')
    drawn_cards = deck.cards.pop(number)
    drawn_cards.each do |card|
      card.deck = temp
    end
    temp.save
  end

  def shuffle!
    @card_deck.cards
  end

  private

  def card_deck_params
    params.require(:card_deck).permit(:name, :posX, :posY)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def find_deck
    @card_deck = CardDeck.find(params[:id])
  end
end
