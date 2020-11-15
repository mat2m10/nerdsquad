class CreateCardTrays < ActiveRecord::Migration[6.0]
  def change
    create_table :card_trays do |t|
      t.float :posX
      t.float :posY
      t.references :games, null: false, foreign_key: true

      t.timestamps
    end
  end
end
