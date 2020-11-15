class CreateDices < ActiveRecord::Migration[6.0]
  def change
    create_table :dices do |t|
      t.float :posX
      t.float :posY
      t.references :dice_tray, null: false, foreign_key: true

      t.timestamps
    end
  end
end
