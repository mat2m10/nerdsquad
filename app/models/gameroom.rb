class Gameroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_one :clone
end
