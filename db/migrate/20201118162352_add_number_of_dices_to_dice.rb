class AddNumberOfDicesToDice < ActiveRecord::Migration[6.0]
  def change
    add_column :dices, :number_of_dices, :integer
  end
end
