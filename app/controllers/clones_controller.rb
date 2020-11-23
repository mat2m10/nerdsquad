class ClonesController < ApplicationController

  def create
    @game = Game.find(params[:game_id])

    #Copy Game
    @clone = Clone.new(game: @game)
    @clone.name = @game.name
    @clone.description = @game.description

    #Copy Board
    @cboard = Cboard.new(clone: @clone)
    @cboard.photo.attach(@game.board.photo.blob)
    @clone.cboard = @cboard
    @clone.cboard.posX = @game.board.posX
    @clone.cboard.posY = @game.board.posY

    #Copy Token
    @game.tokens.each do |token|
      ctoken = Ctoken.new(clone: @clone)
      ctoken.photo.attach(token.photo.blob)
      ctoken.posX = token.posX
      ctoken.posY = token.posY
      ctoken.number_of_tokens = token.number_of_tokens
      ctoken.name = token.name
      ctoken.save
    end

    #Copy Pieces
    @game.pieces.each do |piece|
      cpiece = Cpiece.new(clone: @clone)
      cpiece.photo.attach(piece.photo.blob)
      cpiece.posX = piece.posX
      cpiece.posY = piece.posY
      cpiece.name = piece.name
      cpiece.save
    end

    #Copy card_deck
    @game.card_decks.each do |card_deck|
      ccard_deck = CcardDeck.new(clone: @clone)
      ccard_deck.posX = card_deck.posX
      ccard_deck.posY = card_deck.posY
      ccard_deck.name = card_deck.name
      ccard_deck.save

      #Copy cards
      card_deck.cards.each do |card|
        ccard = Ccard.new(ccard_deck: ccard_deck)
        ccard.photo.attach(card.photo.blob)
        ccard.posX = card.posX
        ccard.posY = card.posY
        ccard.position = card.position || 0
        ccard.name = card.name
        ccard.save
      end
    end



    #Save newly cloned Game
    @clone.save
    redirect_to game_clone_path(@game, @clone)
  end

  def show
    @game = Game.find(params[:game_id])
    @clone = Clone.find(params[:id])
  end

  private

  def clone_params
    params.require(:clone).permit(:name)
  end
end
