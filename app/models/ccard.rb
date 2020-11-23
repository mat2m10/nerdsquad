class Ccard < ApplicationRecord
  belongs_to :ccard_deck
  has_one_attached :photo
end
