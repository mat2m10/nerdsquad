class AddSizeAndAngleToccards < ActiveRecord::Migration[6.0]
  def change
    add_column :ccards, :height, :float, default:200
    add_column :ccards, :width, :float, default:120
    add_column :ccards, :angle, :integer
  end
end
