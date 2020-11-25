class AddSizeAndAngleTocdices < ActiveRecord::Migration[6.0]
  def change
    add_column :cdices, :height, :float, default:150
    add_column :cdices, :width, :float, default:150
    add_column :cdices, :angle, :integer
  end
end
