class Ctoken < ApplicationRecord
  belongs_to :game_clone, class_name: "Clone", foreign_key: :clone_id, inverse_of: :ctokens
  has_one_attached :photo
end
