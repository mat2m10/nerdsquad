class AddSizeAndAngleToctokens < ActiveRecord::Migration[6.0]
  def change
    add_column :ctokens, :height, :float
    add_column :ctokens, :width, :float
    add_column :ctokens, :angle, :integer
  end
end
