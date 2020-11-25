class CreateCboards < ActiveRecord::Migration[6.0]
  def change
    create_table :cboards do |t|
      t.float :posX, default:500
      t.float :posY, default:200
      t.references :clone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
