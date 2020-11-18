class CardDecksController < ApplicationController
  before_action :set_game, only: %i[new create edit shuffle! draw show]

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

  def edit; end

  def show
    @card_deck = CardDeck.find(params[:id])
  end

  def draw!(deck, number)
    @card_deck.cards.last(number)
  end

  def shuffle!
    @card_deck.cards
  end

  private

  def card_deck_params
    params.require(:card_deck).permit(:name)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
