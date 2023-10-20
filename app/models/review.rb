class Review < ApplicationRecord
  belongs_to :wine
  belongs_to :expert

  after_create :recalculate_average_rating_job

  private

  def recalculate_average_rating_job
    RecalculateAverageRatingJob.perform(wine_id)
  end
end
