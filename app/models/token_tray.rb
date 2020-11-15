class TokenTray < ApplicationRecord
  belongs_to :game
  has_many :tokens
end
