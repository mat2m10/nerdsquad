class CreatePieceTrays < ActiveRecord::Migration[6.0]
  def change
    create_table :piece_trays do |t|
      t.float :posX
      t.float :posY
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
