class CardsController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @card = Card.new
  end
end
