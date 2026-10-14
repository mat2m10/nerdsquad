ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_user(name = "player")
    suffix = SecureRandom.hex(4)
    User.create!(email: "#{name}-#{suffix}@example.com", username: "#{name}-#{suffix}", password: "secret123")
  end

  # Builds the record with a photo attached, then saves it.
  def create_with_photo!(model, **attributes)
    record = model.new(attributes)
    record.photo.attach(io: File.open(file_fixture("square.png")), filename: "square.png", content_type: "image/png")
    record.save!
    record
  end

  # A game with one of every component, each with a photo, like the seeds.
  def create_full_game(user, name: "Monopoly", players: 2)
    game = Game.create!(user: user, name: name, number_of_players: players, description: "A test game", saved: true)
    create_with_photo!(Board, game: game, posX: 10, posY: 20, height: 300, width: 300, angle: 0)
    create_with_photo!(Token, game: game, name: "house", posX: 1, posY: 2)
    create_with_photo!(Piece, game: game, name: "car", posX: 3, posY: 4)
    create_with_photo!(Dice, game: game, faces: 6, posX: 5, posY: 6)
    deck = CardDeck.create!(game: game, name: "Chance")
    2.times { |i| create_with_photo!(Card, card_deck: deck, name: "card #{i}", position: i) }
    game
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
