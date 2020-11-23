class CreateCdices < ActiveRecord::Migration[6.0]
  def change
    create_table :cdices do |t|
      t.float :posX
      t.float :posY
      t.integer :faces
      t.integer :number_of_dices
      t.references :clone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
