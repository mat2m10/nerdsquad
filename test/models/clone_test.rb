require 'test_helper'

class CloneTest < ActiveSupport::TestCase
  setup do
    @game = Game.create!(user: create_user, name: "Chess", number_of_players: 2)
    @clone = Clone.create!(game: @game, name: "Chess", number_of_players: 2)
  end

  test "cloned components point back at their clone through game_clone" do
    cpiece = Cpiece.create!(game_clone: @clone, name: "pawn")
    gameroom = Gameroom.create!(name: "room", game_clone: @clone)

    assert_equal @clone, cpiece.reload.game_clone
    assert_equal [cpiece], @clone.cpieces.to_a
    assert_equal gameroom, @clone.reload.gameroom
  end

  test "destroying a clone destroys its gameroom and pieces" do
    Cpiece.create!(game_clone: @clone, name: "pawn")
    Gameroom.create!(name: "room", game_clone: @clone)

    assert_difference -> { Gameroom.count } => -1, -> { Cpiece.count } => -1 do
      @clone.destroy
    end
  end
end
