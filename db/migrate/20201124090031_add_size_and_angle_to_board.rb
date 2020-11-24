class AddSizeAndAngleToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :height, :float, default: 500
    add_column :boards, :width, :float, default: 500
    add_column :boards, :angle, :integer, default: 0
  end
end
