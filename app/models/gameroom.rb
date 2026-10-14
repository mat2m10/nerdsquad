class Gameroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :connections, dependent: :destroy
  has_many :users, through: :connections
  belongs_to :game_clone, class_name: "Clone", foreign_key: :clone_id, inverse_of: :gameroom
end
