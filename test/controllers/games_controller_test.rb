require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
  end

  test "visitors are sent to the login page" do
    get games_path
    assert_redirected_to new_user_session_path
  end

  test "the home page is public" do
    get root_path
    assert_response :success
  end

  test "creating a game assigns it to the current user" do
    sign_in @user
    assert_difference -> { @user.games.count }, 1 do
      post games_path, params: { game: { name: "Catan", number_of_players: 4, description: "Sheep" } }
    end
    game = @user.games.last
    assert_redirected_to game_path(game)
    assert_equal ["Catan", 4], [game.name, game.number_of_players]
  end

  test "index lists and searches games" do
    sign_in @user
    create_full_game(@user, name: "Monopoly")
    create_full_game(@user, name: "Chess")

    get games_path
    assert_response :success
    assert_match "Play Monopoly", response.body
    assert_match "Play Chess", response.body

    get games_path(query: "mono")
    assert_match "Play Monopoly", response.body
    assert_no_match "Play Chess", response.body
  end

  test "index only lists saved games" do
    sign_in @user
    create_full_game(@user, name: "Draft").update!(saved: false)

    get games_path
    assert_no_match "Play Draft", response.body
  end

  test "show renders a game with all its components" do
    sign_in @user
    game = create_full_game(@user)
    get game_path(game)
    assert_response :success
  end

  test "creating a game without a number of players re-renders the form" do
    sign_in @user
    assert_no_difference -> { Game.count } do
      post games_path, params: { game: { name: "Broken", number_of_players: "" } }
    end
    assert_response :unprocessable_entity
    assert_select "form#new_game"
  end

  test "edit renders the form for the requested game" do
    sign_in @user
    game = create_full_game(@user, name: "Monopoly")
    get edit_game_path(game)
    assert_response :success
    assert_select "form#edit_game_#{game.id} input[value='Monopoly']"
  end

  test "update with invalid data re-renders edit" do
    sign_in @user
    game = create_full_game(@user)
    patch game_path(game), params: { game: { number_of_players: "" } }
    assert_response :unprocessable_entity
    assert_equal 2, game.reload.number_of_players
  end

  test "update changes the game" do
    sign_in @user
    game = create_full_game(@user)
    patch game_path(game), params: { game: { name: "Renamed" } }
    assert_redirected_to games_path
    assert_equal "Renamed", game.reload.name
  end
end
