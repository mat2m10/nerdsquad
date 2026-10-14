class Clone < ApplicationRecord
  belongs_to :game
  has_many :ccard_decks, dependent: :destroy, inverse_of: :game_clone
  has_many :ccards, through: :ccard_decks
  has_one :cboard, dependent: :destroy, inverse_of: :game_clone
  has_many :cdices, dependent: :destroy, inverse_of: :game_clone
  has_many :cpieces, dependent: :destroy, inverse_of: :game_clone
  has_many :ctokens, dependent: :destroy, inverse_of: :game_clone
  has_one :gameroom, dependent: :destroy, inverse_of: :game_clone
end
