class AddPositionToCcards < ActiveRecord::Migration[6.0]
  def change
    add_column :ccards, :position, :integer
  end
end
