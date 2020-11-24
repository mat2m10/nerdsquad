class AddSizeAndAngleTotokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :height, :float, default:50
    add_column :tokens, :width, :float, default:50
    add_column :tokens, :angle, :integer, default:0
  end
end
