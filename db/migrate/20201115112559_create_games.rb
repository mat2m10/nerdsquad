class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :description
      t.integer :number_of_players, null: false, validates_numericality_of: { greater_than_or_equal_to: 1 }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
