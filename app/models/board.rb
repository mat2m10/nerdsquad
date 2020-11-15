class Board < ApplicationRecord
  belongs_to :game
  has_many :tiles
end
