class CardDecksController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @card_deck = CardDeck.new
  end

  def create
    @game = Game.find(params[:game_id])
    @card_deck = CardDeck.new(params[:card_deck])
    @card_deck.game = @game
    if @card_deck.save
      flash[:success] = "Card deck successfully created"
      redirect_to new_game_card_deck_card_path(@game, @card_deck)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
end
