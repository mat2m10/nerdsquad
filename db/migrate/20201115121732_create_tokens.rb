class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.float :posX
      t.float :posY
      t.references :token_tray, null: false, foreign_key: true
      t.timestamps
    end
  end
end
