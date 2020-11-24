class AddSizeAndAngleTodices < ActiveRecord::Migration[6.0]
  def change
    add_column :dices, :height, :float
    add_column :dices, :width, :float
    add_column :dices, :angle, :integer
  end
end
