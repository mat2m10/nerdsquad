require "test_helper"

class GameroomChannelTest < ActionCable::Channel::TestCase
  setup do
    owner = create_user("owner")
    game = Game.create!(user: owner, name: "Chess", number_of_players: 2, saved: true)
    @gameroom = Gameroom.create!(name: "room", game_clone: Clone.create!(game: game, name: "Chess", number_of_players: 2))
    @player = create_user("player")
    Connection.create!(user: @player, gameroom: @gameroom)
  end

  test "a player in the room can subscribe to its stream" do
    stub_connection current_user: @player
    subscribe id: @gameroom.id
    assert subscription.confirmed?
    assert_has_stream_for @gameroom
  end

  test "a user who has not joined the room is rejected" do
    stub_connection current_user: create_user("stranger")
    subscribe id: @gameroom.id
    assert subscription.rejected?
  end

  test "an unknown room is rejected" do
    stub_connection current_user: @player
    subscribe id: 0
    assert subscription.rejected?
  end
end
