class CcardDeck < ApplicationRecord
  belongs_to :clone
  has_many :ccards, dependent: :destroy
end
