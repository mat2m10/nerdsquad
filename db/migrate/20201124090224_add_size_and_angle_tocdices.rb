class AddSizeAndAngleTocdices < ActiveRecord::Migration[6.0]
  def change
    add_column :cdices, :height, :float
    add_column :cdices, :width, :float
    add_column :cdices, :angle, :integer
  end
end
