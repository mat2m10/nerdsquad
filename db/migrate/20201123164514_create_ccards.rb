class CreateCcards < ActiveRecord::Migration[6.0]
  def change
    create_table :ccards do |t|
      t.float :posX, default:500
      t.float :posY, default:500
      t.string :visibility
      t.string :name
      t.references :ccard_deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
