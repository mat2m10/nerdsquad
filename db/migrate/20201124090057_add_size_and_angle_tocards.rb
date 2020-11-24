class AddSizeAndAngleTocards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :height, :float
    add_column :cards, :width, :float
    add_column :cards, :angle, :integer
  end
end
