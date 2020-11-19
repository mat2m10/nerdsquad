class CardsController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @card_deck = CardDeck.find(params[:card_deck_id])
    @card = Card.new
  end

  def create
    @game = Game.find(params[:game_id])
    @card_deck = CardDeck.find(params[:card_deck_id])
    @card = Card.new(card_params)
    @card.card_deck = @card_deck
    if @card.save
      flash[:success] = "Card successfully created"
      redirect_to game_card_deck_path(@game, @card_deck)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @card_deck = CardDeck.find(params[:card_deck_id])
    @card = Card.find(params[:id])
    @card.update!(card_params)
    if @card.card_deck.game.gamerooms.last
      GameroomChannel.broadcast_to(
      @card.card_deck.game.gamerooms.last,
      "moved"
    )
    else

      # redirect_to game_path(params[:game_id])
    end
    if @card.card_deck.game.gamerooms.last
      redirect_back(fallback_location: gameroom_path(@card.game.gamerooms.last))
    end
  end


  def show
    @card_deck = CardDeck.find(params[:card_deck_id])
  end


  private

  def card_params
    params.require(:card).permit(:photo, :name, :posX, :posY)
  end

end
