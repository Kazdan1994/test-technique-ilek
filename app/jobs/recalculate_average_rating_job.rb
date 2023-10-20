class RecalculateAverageRatingJob < ApplicationJob
  @queue = :recalculate_average_rating

  def self.perform(wine_id)
    wine = Wine.find(wine_id)
    wine.recalculate_average_rating
  end
end
