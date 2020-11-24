class AddSizeAndAngleToccarddecks < ActiveRecord::Migration[6.0]
  def change
    add_column :ccard_decks, :height, :float
    add_column :ccard_decks, :width, :float
    add_column :ccard_decks, :angle, :integer
  end
end
