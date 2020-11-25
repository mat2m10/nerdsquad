class AddSizeAndAngleTocboard < ActiveRecord::Migration[6.0]
  def change
    add_column :cboards, :height, :float, default:500
    add_column :cboards, :width, :float, default:500
    add_column :cboards, :angle, :integer, default:0
  end
end
