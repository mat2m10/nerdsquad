require 'test_helper'

# Owners change their own games; players change only gamerooms they joined.
class AuthorizationTest < ActionDispatch::IntegrationTest
  setup do
    @owner = create_user("owner")
    @other = create_user("other")
    @game = create_full_game(@owner, name: "Monopoly")
  end

  test "another user cannot edit, update or delete someone else's game" do
    log_in @other
    get edit_game_path(@game)
    assert_response :not_found

    patch game_path(@game), params: { game: { name: "Hijacked" } }
    assert_response :not_found
    assert_equal "Monopoly", @game.reload.name

    assert_no_difference -> { Game.count } do
      delete game_path(@game)
    end
    assert_response :not_found
  end

  test "the owner can still update and delete their game" do
    log_in @owner
    patch game_path(@game), params: { game: { name: "Mine" } }
    assert_equal "Mine", @game.reload.name

    assert_difference -> { Game.count }, -1 do
      delete game_path(@game)
    end
  end

  test "another user cannot change or delete the components of someone else's game" do
    log_in @other
    piece = @game.pieces.first
    patch game_piece_path(@game, piece), params: { piece: { posX: 999 } }, headers: { "HTTP_REFERER" => "/games" }
    assert_response :not_found
    assert_not_equal 999, piece.reload.posX

    assert_no_difference -> { Piece.count + Token.count + Dice.count + Board.count + Card.count } do
      delete game_piece_path(@game, piece)
      delete game_token_path(@game, @game.tokens.first)
      delete game_dice_path(@game, @game.dices.first)
      delete game_board_path(@game, @game.board)
      deck = @game.card_decks.first
      delete game_card_deck_card_path(@game, deck, deck.cards.first)
    end

    post game_pieces_path(@game), params: { piece: { name: "intruder" } }
    assert_response :not_found
    assert_not @game.pieces.exists?(name: "intruder")
  end

  test "a component id from another game is not reachable through your own game" do
    mine = create_full_game(@other, name: "Mine")
    log_in @other
    foreign_piece = @game.pieces.first

    assert_no_difference -> { Piece.count } do
      delete game_piece_path(mine, foreign_piece)
    end
    assert_response :not_found
  end

  test "the owner can still change components" do
    log_in @owner
    piece = @game.pieces.first
    patch game_piece_path(@game, piece), params: { piece: { posX: 123 } }, headers: { "HTTP_REFERER" => "/games" }
    assert_equal 123, piece.reload.posX
  end

  test "only players in the gameroom can move pieces, chat or close it" do
    log_in @owner
    post game_clones_path(@game)
    gameroom = Gameroom.last
    clone = gameroom.game_clone
    get gameroom_path(gameroom) # joins the owner as a player
    cpiece = clone.cpieces.first
    sign_out @owner

    log_in @other # never opened the room
    patch game_clone_cpiece_path(@game, clone, cpiece), params: { cpiece: { posX: 999 } },
                                                        headers: { "HTTP_REFERER" => "/" }
    assert_response :not_found
    assert_not_equal 999, cpiece.reload.posX

    assert_no_difference -> { Message.count } do
      post gameroom_messages_path(gameroom), params: { message: { content: "spam" } }
    end
    assert_response :not_found

    assert_no_difference -> { Gameroom.count } do
      delete gameroom_path(gameroom)
    end
    assert_response :not_found
  end

  test "joining a gameroom does not let a player close it; the game owner can" do
    log_in @owner
    post game_clones_path(@game)
    gameroom = Gameroom.last
    sign_out @owner

    log_in @other
    get gameroom_path(gameroom) # joins as a player
    assert gameroom.users.exists?(@other.id)
    assert_no_difference -> { Gameroom.count } do
      delete gameroom_path(gameroom)
    end
    assert_response :not_found
    sign_out @other

    log_in @owner
    assert_difference -> { Gameroom.count }, -1 do
      delete gameroom_path(gameroom)
    end
  end

  test "a draft game cannot be played by other users, only by its owner" do
    @game.update!(saved: false)
    log_in @other
    assert_no_difference -> { Clone.count } do
      post game_clones_path(@game)
    end
    assert_response :not_found
    sign_out @other

    log_in @owner
    assert_difference -> { Clone.count }, 1 do
      post game_clones_path(@game)
    end
  end

  test "the game page shows edit and delete links only to the owner" do
    log_in @other
    get game_path(@game)
    assert_response :success
    assert_select "a[href=?]", game_piece_path(@game, @game.pieces.first), count: 0
    assert_select "a[href=?]", new_game_piece_path(@game), count: 0
    sign_out @other

    log_in @owner
    get game_path(@game)
    assert_select "a[href=?]", game_piece_path(@game, @game.pieces.first)
    assert_select "a[href=?]", new_game_piece_path(@game)
  end

  test "players in the gameroom can move its pieces" do
    log_in @owner
    post game_clones_path(@game)
    gameroom = Gameroom.last
    clone = gameroom.game_clone
    get gameroom_path(gameroom)

    cpiece = clone.cpieces.first
    patch game_clone_cpiece_path(@game, clone, cpiece), params: { cpiece: { posX: 321 } },
                                                        headers: { "HTTP_REFERER" => gameroom_path(gameroom) }
    assert_redirected_to gameroom_path(gameroom)
    assert_equal 321, cpiece.reload.posX
  end

  test "a piece from another clone is not reachable through your own gameroom" do
    log_in @owner
    post game_clones_path(@game)
    mine = Gameroom.last
    get gameroom_path(mine)
    post game_clones_path(@game)
    theirs = Gameroom.last.game_clone

    patch game_clone_cpiece_path(@game, mine.game_clone, theirs.cpieces.first), params: { cpiece: { posX: 7 } },
                                                                               headers: { "HTTP_REFERER" => "/" }
    assert_response :not_found
  end
end
