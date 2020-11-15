class DiceTray < ApplicationRecord
  belongs_to :game
  has_many :dices
end
