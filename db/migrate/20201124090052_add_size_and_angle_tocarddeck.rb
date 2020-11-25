class AddSizeAndAngleTocarddeck < ActiveRecord::Migration[6.0]
  def change
    add_column :card_decks, :height, :float, default:200
    add_column :card_decks, :width, :float, default:120
    add_column :card_decks, :angle, :integer
  end
end
