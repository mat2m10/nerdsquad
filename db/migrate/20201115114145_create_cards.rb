class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.float :posX, default:500
      t.float :posY, default:500
      t.string :visibility
      t.references :card_deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
