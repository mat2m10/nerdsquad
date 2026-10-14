require 'test_helper'

class ClonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @game = create_full_game(@user)
  end

  test "cloning needs a login" do
    assert_no_difference -> { Clone.count } do
      post game_clones_path(@game)
    end
    assert_redirected_to new_user_session_path
  end

  test "playing a game copies every component into a clone and opens a gameroom" do
    sign_in @user
    assert_difference -> { Clone.count } => 1, -> { Gameroom.count } => 1 do
      post game_clones_path(@game)
    end

    clone = Clone.last
    gameroom = clone.gameroom
    assert_redirected_to gameroom_path(gameroom)
    assert_equal [@game, @game.name, 2], [clone.game, clone.name, clone.number_of_players]
    assert_equal "#{clone.name}-#{clone.id}", gameroom.name

    assert_equal [10.0, 20.0], [clone.cboard.posX, clone.cboard.posY]
    assert_equal ["house"], clone.ctokens.map(&:name)
    assert_equal ["car"], clone.cpieces.map(&:name)
    assert_equal [6], clone.cdices.map(&:faces)
    assert_equal ["Chance", "Chance"], clone.ccard_decks.map(&:name)
    assert_equal ["card 0", "card 1"], clone.ccards.order(:position).map(&:name)

    # Copies share the original photo blobs instead of re-uploading them.
    assert_equal @game.board.photo.blob, clone.cboard.photo.blob
    assert(clone.cpieces.all? { |p| p.photo.attached? })
  end

  test "the gameroom renders and joins the player" do
    sign_in @user
    post game_clones_path(@game)
    gameroom = Gameroom.last

    get gameroom_path(gameroom)
    assert_response :success
    assert_select "#elements[data-gameroom-id='#{gameroom.id}']"
    assert_includes gameroom.users.reload, @user
  end

  test "a full gameroom turns extra players away" do
    sign_in @user
    post game_clones_path(@game)
    gameroom = Gameroom.last
    2.times { Connection.create!(user: create_user, gameroom: gameroom) }

    get gameroom_path(gameroom)
    assert_redirected_to games_path
  end
end
