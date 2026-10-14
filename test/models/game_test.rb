require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "a game needs an owner and a number of players" do
    assert_raises(ActiveRecord::RecordInvalid) { Game.create!(name: "No owner", number_of_players: 2) }
    assert_raises(ActiveRecord::NotNullViolation) { Game.create!(user: create_user, name: "No players") }
  end

  test "search_by_name matches name prefixes" do
    user = create_user
    chess = Game.create!(user: user, name: "Chess", number_of_players: 2)
    Game.create!(user: user, name: "Monopoly", number_of_players: 4)

    assert_equal [chess], Game.search_by_name("che").to_a
  end

  test "destroying a game destroys its components and clones" do
    game = create_full_game(create_user)
    Clone.create!(game: game, name: game.name, number_of_players: 2)

    assert_difference -> { Board.count } => -1, -> { Piece.count } => -1, -> { Card.count } => -2,
                      -> { Clone.count } => -1 do
      game.destroy
    end
  end
end
