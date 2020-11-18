class AddNumberOfTokensToTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :number_of_tokens, :integer
  end
end
