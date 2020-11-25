class AddSizeAndAngleToctokens < ActiveRecord::Migration[6.0]
  def change
    add_column :ctokens, :height, :float, default:50
    add_column :ctokens, :width, :float, default:50
    add_column :ctokens, :angle, :integer, default:0
  end
end
