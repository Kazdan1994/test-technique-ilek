require 'elasticsearch/model'

# Wine model
class Wine < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :reviews, dependent: :destroy
  has_many :prices, dependent: :destroy

  index_name "wines-#{Rails.env}"

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text'
      indexes :properties, type: 'text'
      indexes :marketplace, type: 'text'
      indexes :note, type: 'integer'
      indexes :wine_type, type: 'text'
    end
  end

  def as_indexed_json(_ = {})
    as_json(only: %i[name properties marketplace note wine_type])
  end

  def average_rating
    if reviews.count.positive?
      reviews.average(:rating).to_f
    else
      0.0
    end
  end
end
