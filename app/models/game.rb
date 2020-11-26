class Game < ApplicationRecord
  belongs_to :user
  has_many :card_decks, dependent: :destroy
  has_many :cards, through: :card_decks
  has_one :board, dependent: :destroy
  has_many :dices, dependent: :destroy
  has_many :tokens, dependent: :destroy
  has_many :pieces, dependent: :destroy
  has_many :clones, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }
end
