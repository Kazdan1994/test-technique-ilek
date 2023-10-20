require 'elasticsearch/model'

# Wine model
class Wine < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_create ->(wine) { ActionCable.server.broadcast 'WineChannel', wine: }

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

  def matches_user_searches?
    user_searches = Search.where(expert_id: current_expert.id)
    user_searches.each do |user_search|
      return true if Search.index(user_search.query)
    end
    false
  end

  def notify_user_of_match
    Notice.create(
      recipient: current_expert,
      subject: 'New wine matches your previous searches!',
      body: "The new wine #{name} matches your previous searches for #{search_terms.join(', ')}."
    )
  end

end
