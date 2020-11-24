class AddSizeAndAngleTocpieces < ActiveRecord::Migration[6.0]
  def change
    add_column :cpieces, :height, :float
    add_column :cpieces, :width, :float
    add_column :cpieces, :angle, :integer
  end
end
