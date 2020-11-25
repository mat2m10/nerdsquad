class AddSizeAndAngleTocards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :height, :float, default:200
    add_column :cards, :width, :float, default:120
    add_column :cards, :angle, :integer
  end
end
