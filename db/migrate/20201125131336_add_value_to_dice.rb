class AddValueToDice < ActiveRecord::Migration[6.0]
  def change
    add_column :dices, :value, :integer, default: 1
  end
end
