class ClonesController < ApplicationController
  before_action :set_game, only: %i[create show]
  before_action :set_clone, only: %i[show]

  def create
    # Copy Game
    @clone = Clone.new(game: @game, name: @game.name, description: @game.description)

    # Copy Board
    @cboard = Cboard.create(clone: @clone, posX: @game.board.posX, posY: @game.board.posY)
    @cboard.photo.attach(@game.board.photo.blob)

    # Copy Token
    @game.tokens.each do |token|
      ctoken = Ctoken.create(clone: @clone, posX: token.posX, posY: token.posY, name: token.name)
      # Uncomment if needed
      # ctoken.number_of_tokens = token.number_of_tokens
      ctoken.photo.attach(token.photo.blob)
    end

    # Copy Pieces
    @game.pieces.each do |piece|
      cpiece = Cpiece.create(clone: @clone, posX: piece.posX, posY: piece.posY, name: piece.name)
      cpiece.photo.attach(piece.photo.blob)
    end

    # Copy card_deck
    @game.card_decks.each do |card_deck|
      deck = CcardDeck.create(clone: @clone, posX: card_deck.posX, posY: card_deck.posY, name: card_deck.name)

      # Copy cards
      card_deck.cards.each do |card|
        ccard = Ccard.create(ccard_deck: deck, posX: card.posX, posY: card.posY, name: card.name, position: card.position)
        ccard.photo.attach(card.photo.blob)
      end
    end

    # Save newly cloned Game
    @clone.save
    redirect_to game_clone_gameroom_path(@game, @clone)
  end

  def show
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_clone
    @clone = Clone.find(params[:id])
  end

  def clone_params
    params.require(:clone).permit(:name)
  end
end
