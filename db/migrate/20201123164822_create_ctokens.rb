class CreateCtokens < ActiveRecord::Migration[6.0]
  def change
    create_table :ctokens do |t|
      t.float :posX, default:500
      t.float :posY, default:500
      t.string :name
      t.integer :number_of_tokens
      t.references :clone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
