class Review < ApplicationRecord
  belongs_to :wine
  belongs_to :expert
end
