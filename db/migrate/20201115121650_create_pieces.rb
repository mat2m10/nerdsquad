class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.float :posX
      t.float :posY
      t.references :piece_tray, null: false, foreign_key: true

      t.timestamps
    end
  end
end
