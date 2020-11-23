class CreateClones < ActiveRecord::Migration[6.0]
  def change
    create_table :clones do |t|
      t.string :name
      t.string :description
      t.integer :number_of_players
      t.integer :connected_players
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
