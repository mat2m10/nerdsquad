class Gameroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :connections, dependent: :destroy
  has_many :users, through: :connections
  belongs_to :clone
end
