# Reviews controller
class ReviewsController < ApplicationController
  before_action :authenticate_expert!
  before_action :set_wine, only: %i[show create]

  def show
    @reviews = @wine.reviews
    @review = Review.new
  end

  def create
    @review = @wine.reviews.build(review_params)
    @review.expert_id = current_expert.id
    if @review.save
      redirect_to wine_path(@wine)
    else
      render :show
    end
  end

  private

  def set_wine
    @wine = Wine.find(params[:wine_id])
  end

  def review_params
    params.require(:review).permit(:message, :rating)
  end
end
