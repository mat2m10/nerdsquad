class Gameroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    belongs_to :game
end
