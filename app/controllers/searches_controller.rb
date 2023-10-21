class SearchesController < ApplicationController
  include Pagy::Backend

  def index
    if user_signed_in?
      @pagy, @searches = pagy(current_user.searches.limit(5))
    elsif expert_signed_in?
      @pagy, @searches = pagy(current_expert.searches.limit(5))
    else
      redirect_to root_path
    end
  end
end
