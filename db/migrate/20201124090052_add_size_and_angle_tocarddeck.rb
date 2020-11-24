class AddSizeAndAngleTocarddeck < ActiveRecord::Migration[6.0]
  def change
    add_column :card_decks, :height, :float
    add_column :card_decks, :width, :float
    add_column :card_decks, :angle, :integer
  end
end
