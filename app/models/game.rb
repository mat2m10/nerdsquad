class Game < ApplicationRecord
  belongs_to :user
  has_many :card_decks
  has_many :cards, through: :card_decks
  has_many :boards
end
