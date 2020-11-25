class CreateCardDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :card_decks do |t|
      t.float :posX, default:500
      t.float :posY, default:500
      t.references :game, null: false, foreign_key: true
      t.timestamps
    end
  end
end
