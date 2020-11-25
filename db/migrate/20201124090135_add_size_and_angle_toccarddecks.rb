class AddSizeAndAngleToccarddecks < ActiveRecord::Migration[6.0]
  def change
    add_column :ccard_decks, :height, :float, default:200
    add_column :ccard_decks, :width, :float, default:120
    add_column :ccard_decks, :angle, :integer
  end
end
