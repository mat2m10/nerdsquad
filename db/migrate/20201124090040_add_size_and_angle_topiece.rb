class AddSizeAndAngleTopiece < ActiveRecord::Migration[6.0]
  def change
    add_column :pieces, :height, :float
    add_column :pieces, :width, :float
    add_column :pieces, :angle, :integer
  end
end
