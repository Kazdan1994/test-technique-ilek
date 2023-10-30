# frozen_string_literal: true

# Wines controller
class WinesController < ApplicationController
  include Pagy::Backend
  include WineHelper

  before_action :set_wine, only: %i[show]

  def index
    @pagy, @wines = pagy(Wine.limit(6))
  end

  def show
    per_page = 3
    @wine = Wine.includes(:reviews, :prices).find(params[:id])
    all_reviews = @wine.reviews.order(Arel.sql("CASE WHEN reviews.expert_id = #{current_expert&.id.to_i} THEN 0 ELSE 1 END, reviews.updated_at DESC"))
    @prices = @wine.prices.order(:date)

    @pagy, @paginated_reviews = pagy(all_reviews, items: per_page)
  end

  def search
    @pagy, @wines = search_wines
    redirect_to_last_page if @pagy.pages < params[:page].to_i
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end
end
