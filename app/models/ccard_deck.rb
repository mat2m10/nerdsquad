class CcardDeck < ApplicationRecord
  belongs_to :game_clone, class_name: "Clone", foreign_key: :clone_id, inverse_of: :ccard_decks
  has_many :ccards, dependent: :destroy

  def draw!
    temp = CcardDeck.new(game: clone.game, name: 'temp', blind?: true)
    drawn_ccard = ccards.pop
    drawn_ccard.deck = temp
    drawn_ccard.save
    temp.save
  end

  def shuffle!
    range = Range.new(0...ccards.size)
    ccards.each do |ccard|
      ccard.update position: range.to_a.sample
    end
    flash.now "Deck shuffled!"
  end
end
