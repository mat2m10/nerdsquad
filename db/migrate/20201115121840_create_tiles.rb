class CreateTiles < ActiveRecord::Migration[6.0]
  def change
    create_table :tiles do |t|
      t.float :posX
      t.float :posY
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
