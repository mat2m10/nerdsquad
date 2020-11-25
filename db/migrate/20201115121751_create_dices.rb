class CreateDices < ActiveRecord::Migration[6.0]
  def change
    create_table :dices do |t|
      t.float :posX, default:500
      t.float :posY, default:500
      t.integer :faces, validates: { greater_than_or_equal_to: 1 }
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
