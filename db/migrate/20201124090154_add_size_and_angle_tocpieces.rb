class AddSizeAndAngleTocpieces < ActiveRecord::Migration[6.0]
  def change
    add_column :cpieces, :height, :float, default: 50
    add_column :cpieces, :width, :float, default: 50
    add_column :cpieces, :angle, :integer, default: 0
  end
end
