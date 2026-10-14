class Cpiece < ApplicationRecord
  belongs_to :game_clone, class_name: "Clone", foreign_key: :clone_id, inverse_of: :cpieces
  has_one_attached :photo
end
