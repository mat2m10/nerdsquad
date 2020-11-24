class AddTheCloneRefToGamerooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :gamerooms, :clone, foreign_key: true
  end
end
