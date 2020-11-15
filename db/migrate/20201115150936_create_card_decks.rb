class CreateCardDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :card_decks do |t|
      t.float :posX
      t.float :posY
      t.references :card_trays, null: false, foreign_key: true

      t.timestamps
    end
  end
end
