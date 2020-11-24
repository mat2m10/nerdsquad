class ClonesController < ApplicationController
  before_action :set_game, only: %i[create show]
  before_action :set_clone, only: %i[show]

  def create
    # Copy Game
    @clone = Clone.new(
      game: @game,
      name: @game.name,
      description: @game.description
    )

    # Copy Board
    @cboard = Cboard.create(
      clone: @clone,
      posX: @game.board.posX,
      posY: @game.board.posY,
      height: @game.board.height,
      width: @game.board.width,
      angle: @game.board.angle
    )
    @cboard.photo.attach(@game.board.photo.blob)

    # Copy Tokens
    @game.tokens.each do |token|
      # Copy Token
      ctoken = Ctoken.create(
        clone: @clone,
        posX: token.posX,
        posY: token.posY,
        name: token.name,
        height: token.height,
        width: token.width,
        angle: token.angle
      )
      # Uncomment if needed
      # ctoken.number_of_tokens = token.number_of_tokens
      ctoken.photo.attach(token.photo.blob)
    end

    # Copy Pieces
    @game.pieces.each do |piece|
      # Copy Piece
      cpiece = Cpiece.create(
        clone: @clone,
        posX: piece.posX,
        posY: piece.posY,
        name: piece.name,
        height: piece.height,
        width: piece.width,
        angle: piece.angle
      )
      cpiece.photo.attach(piece.photo.blob)
    end

    # Copy Card_decks
    @game.card_decks.each do |card_deck|
      # Copy Card_deck
      ccard_deck = CcardDeck.create(
        clone: @clone,
        posX: card_deck.posX,
        posY: card_deck.posY,
        name: card_deck.name,
        height: card_deck.height,
        width: card_deck.width,
        angle: card_deck.angle
      )

      # Copy cards
      card_deck.cards.each do |card|
        # Copy Card
        ccard = Ccard.create(
          ccard_deck: ccard_deck,
          posX: card.posX,
          posY: card.posY,
          name: card.name,
          position: card.position,
          height: token.height,
          width: token.width,
          angle: token.angle
        )
        ccard.photo.attach(card.photo.blob)
      end
    end

    # Save newly cloned Game
    if @clone.save
      redirect_to game_clone_path(@game, @clone)
    else
      flash[:error] = "Couldn't create the game instance"
      redirect_to games_path
    end
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
