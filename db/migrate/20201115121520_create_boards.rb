class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.float :posX, default:500
      t.float :posY, default:200
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
