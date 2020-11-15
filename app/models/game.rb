class Game < ApplicationRecord
  belongs_to :user
  has_many :card_decks
  has_many :cards, through: :card_decks
  has_many :boards
  has_many :tiles, through: :boards
  has_many :dice_trays
  has_many :dices, through: :dice_trays
  has_many :token_trays
  has_many :tokens, through: :token_trays
  has_many :pieces_trays
  has_many :pieces, through: :pieces_trays
end
