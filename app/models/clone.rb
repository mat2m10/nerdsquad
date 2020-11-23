class Clone < ApplicationRecord
  belongs_to :game
  has_many :ccard_decks, dependent: :destroy
  has_many :ccards, through: :ccard_decks
  has_one :cboard, dependent: :destroy
  has_many :cdices, dependent: :destroy
  has_many :cpieces, dependent: :destroy
  has_many :ctokens, dependent: :destroy
end
