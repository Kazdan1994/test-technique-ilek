class Search < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :expert, optional: true
end
