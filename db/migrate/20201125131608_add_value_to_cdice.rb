class AddValueToCdice < ActiveRecord::Migration[6.0]
  def change
    add_column :cdices, :value, :integer, default: 1
  end
end
