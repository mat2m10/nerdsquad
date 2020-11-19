class CardsController < ApplicationController
  before_action :set_game, only: %i[new create update]
  before_action :set_card_deck, only: %i[new create show update]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.card_deck = @card_deck
    @card.position = @card_deck.cards.count + 1
    if @card.save
      flash[:success] = "Card successfully created"
      redirect_to game_card_deck_path(@game, @card_deck)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @card.update!(card_params)
    return unless @card.card_deck.game.gamerooms.last

    GameroomChannel.broadcast_to(@card.card_deck.game.gamerooms.last, "moved")
    redirect_back(fallback_location: gameroom_path(@card.game.gamerooms.last))
    # else
    # redirect_to game_path(params[:game_id])
  end

  def show; end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_card_deck
    @card_deck = CardDeck.find(params[:card_deck_id])
  end

  def card_params
    params.require(:card).permit(:photo, :name, :position, :posX, :posY)
  end
end
