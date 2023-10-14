require 'elasticsearch/model'

# Wine model
class Wine < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "wines-#{Rails.env}"

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text'
      indexes :properties, type: 'text'
      indexes :marketplace, type: 'text'
    end
  end

  def as_indexed_json(_ = {})
    as_json(only: %i[name properties marketplace])
  end
end
