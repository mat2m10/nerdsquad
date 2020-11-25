class AddSizeAndAngleTopiece < ActiveRecord::Migration[6.0]
  def change
    add_column :pieces, :height, :float, default: 50
    add_column :pieces, :width, :float, default: 50
    add_column :pieces, :angle, :integer, default: 0
  end
end
