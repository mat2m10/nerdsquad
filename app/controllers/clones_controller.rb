class ClonesController < ApplicationController
  before_action :set_game, only: %i[create show]
  before_action :set_clone, only: %i[show]
  def new; end

  def create
    @clone = Clone.new(game: @game, name: @game.name, number_of_players: @game.number_of_players,
                       description: @game.description)
    create_cboard if @game.board
    create_ctokens
    create_cpieces
    create_cdices
    @game.card_decks.each { |deck| deck.cards.each { |card| create_ccard(card, create_ccard_deck(deck)) } }
    redirect_to games_path and return unless @clone.save

    @gameroom = Gameroom.create(name: "#{@clone.name}-#{@clone.id}", clone: @clone)
    redirect_to gameroom_path(@gameroom)
  end

  def show; end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_clone
    @clone = Clone.find(params[:id])
  end

  def create_cboard
    @cboard = Cboard.create(
      clone: @clone,
      posX: @game.board.posX,
      posY: @game.board.posY,
      height: @game.board.height,
      width: @game.board.width,
      angle: @game.board.angle
    ).photo.attach(@game.board.photo.blob)
  end

  def create_ctoken(token)
    # Copy Token
    Ctoken.create(
      clone: @clone,
      posX: token.posX,
      posY: token.posY,
      name: token.name,
      height: token.height,
      width: token.width,
      angle: token.angle
    ).photo.attach(token.photo.blob)
  end

  def create_ctokens
    @game.tokens.each { |token| create_ctoken(token) }
  end

  def create_cpiece(piece)
    Cpiece.create(
      clone: @clone,
      posX: piece.posX,
      posY: piece.posY,
      name: piece.name,
      height: piece.height,
      width: piece.width,
      angle: piece.angle
    ).photo.attach(piece.photo.blob)
  end

  def create_cpieces
    @game.pieces.each { |piece| create_cpiece(piece) }
  end

  def create_ccard_deck(card_deck)
    CcardDeck.create(
      clone: @clone,
      posX: card_deck.posX,
      posY: card_deck.posY,
      name: card_deck.name,
      height: card_deck.height,
      width: card_deck.width,
      angle: card_deck.angle
    )
  end

  def create_ccard(card, ccard_deck)
    Ccard.create(
      ccard_deck: ccard_deck,
      posX: card.posX,
      posY: card.posY,
      name: card.name,
      position: card.position,
      height: card.height,
      width: card.width,
      angle: card.angle
    ).photo.attach(card.photo.blob)
  end

  def create_cdice(dice)
    Cdice.create(
      clone: @clone,
      posX: dice.posX,
      posY: dice.posY,
      faces: dice.faces,
      height: dice.height,
      width: dice.width,
      angle: dice.angle,
      value: 1
    ).photo.attach(dice.photo.blob)
  end

  def create_cdices
    @game.dices.each { |dice| create_cdice(dice) }
  end
end



