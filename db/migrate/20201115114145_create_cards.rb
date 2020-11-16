class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.float :posX
      t.float :posYµ
      t.string :visibility
      t.references :card_deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
