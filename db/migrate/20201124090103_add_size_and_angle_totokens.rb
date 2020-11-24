class AddSizeAndAngleTotokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :height, :float
    add_column :tokens, :width, :float
    add_column :tokens, :angle, :integer
  end
end
