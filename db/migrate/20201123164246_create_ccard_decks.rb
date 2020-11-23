class CreateCcardDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :ccard_decks do |t|
      t.float :posX
      t.float :posY
      t.string :name
      t.references :clone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
