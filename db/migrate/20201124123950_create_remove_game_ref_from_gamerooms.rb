class CreateRemoveGameRefFromGamerooms < ActiveRecord::Migration[6.0]
  def change
    remove_column :gamerooms, :user_id
    remove_column :gamerooms, :clone_id
  end
end
