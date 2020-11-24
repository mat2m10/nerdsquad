class AddCloneRefToGamerooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :gamerooms, :clone, null: false, foreign_key: true
  end
end
