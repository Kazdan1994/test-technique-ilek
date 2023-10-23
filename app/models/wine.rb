# frozen_string_literal: true

# Wine Model
class Wine < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  extend Pagy::ElasticsearchRails

  belongs_to :recipient, class_name: 'User'
  belongs_to :recipient, class_name: 'Expert'

  after_create_commit :wine_matches_previous_search

  has_many :reviews, dependent: :destroy
  has_many :prices, dependent: :destroy

  index_name "wines-#{Rails.env}"

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text'
      indexes :properties, type: 'text'
      indexes :price, type: 'float'
      indexes :marketplace, type: 'text'
      indexes :note, type: 'float'
      indexes :wine_type, type: 'text'
    end
  end

  def as_indexed_json(_ = {})
    as_json(only: %i[name properties price marketplace note wine_type])
  end

  def average_rating
    if reviews.count.positive?
      reviews.average(:rating).to_f
    else
      0.0
    end
  end

  # This method calculates the average rating of the wine
  def recalculate_average_rating
    self.note = average_rating
    save
  end

  def wine_matches_previous_search
    wine = self
    search_results = Search.where('query LIKE ?', "%#{wine.id}%")
    user_ids = search_results.pluck(:user_id)
    expert_ids = search_results.pluck(:expert_id)

    user_ids.each do |_user_id|
      # Notify the user
      NewMessageNotification.with(message: self).deliver_later(recipient)
    end

    expert_ids.each do |_expert_id|
      # Notify the expert
      NewMessageNotification.with(message: self).deliver_later(recipient)
    end
  end
end
