class AddSizeAndAngleTocboard < ActiveRecord::Migration[6.0]
  def change
    add_column :cboards, :height, :float
    add_column :cboards, :width, :float
    add_column :cboards, :angle, :integer
  end
end
