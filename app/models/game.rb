class Game < ApplicationRecord
  belongs_to :user
  has_many :card_decks
  has_many :cards, through: :card_decks
  has_one :board
  has_many :dices
  has_many :tokens
  has_many :pieces
  has_many :gamerooms
  has_many :users, through: :session

  include PgSearch::Model
  pg_search_scope :search_by_name,
  against: [ :name ],
  using: {
  tsearch: { prefix: true } 
}
end
