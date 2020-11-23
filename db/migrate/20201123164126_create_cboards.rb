class CreateCboards < ActiveRecord::Migration[6.0]
  def change
    create_table :cboards do |t|
      t.float :posX
      t.float :posY
      t.references :clone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
