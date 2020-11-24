class AddSizeAndAngleToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :height, :float
    add_column :boards, :width, :float
    add_column :boards, :angle, :integer
  end
end
