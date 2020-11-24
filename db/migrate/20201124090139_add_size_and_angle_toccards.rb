class AddSizeAndAngleToccards < ActiveRecord::Migration[6.0]
  def change
    add_column :ccards, :height, :float
    add_column :ccards, :width, :float
    add_column :ccards, :angle, :integer
  end
end
