class CardDecksController < ApplicationController
  before_action :set_game, only: %i[new create show edit update shuffle! draw]
  before_action :set_deck, only: %i[show edit update shuffle!]

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

  def edit; end

  def update
    @card_deck.update!(card_deck_params)
    num = @card_deck.cards.length
    @card_deck.cards.each do |card|
      card.posX = @card_deck.posX + num
      card.posY = @card_deck.posY + num
      num -= 1
      card.save
    end

    if @game.gamerooms.last
      GameroomChannel.broadcast_to(
        @game.gamerooms.last,
        "moved"
      )
      redirect_back(fallback_location: gameroom_path(@game.gamerooms.last)) and return
    end
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

  def set_deck
    @card_deck = CardDeck.find(params[:id])
  end
end
