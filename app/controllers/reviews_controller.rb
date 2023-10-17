class ReviewsController < ApplicationController
  before_action :authenticate_expert!
  before_action :set_wine, only: %i[show create update]

  def show
    @reviews = @wine.reviews
    @review = @wine.reviews.find_by(expert_id: current_expert.id) || @wine.reviews.build
  end

  def create
    @review = @wine.reviews.find_or_initialize_by(
      expert_id: current_expert.id
    )
    @review.assign_attributes(review_params)

    if @review.save
      redirect_to wine_path(@wine)
    else
      render :show
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
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
