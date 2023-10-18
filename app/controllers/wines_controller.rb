# Wines controller
class WinesController < ApplicationController
  include Pagy::Backend
  before_action :set_wine, only: %i[show]

  def index
    @pagy, @wines = pagy(Wine.limit(5))
  end

  def search
    @pagy, @wines = search_wines
    redirect_to_last_page if @pagy.pages < params[:page].to_i
  end

  private

  def search_wines
    if params[:q].present?
      save_search
      pagy(Wine.__elasticsearch__.search(query: wildcard_query).records, items: 5)
    else
      pagy(Wine.all, items: 5)
    end
  end

  def save_search
    return unless user_signed_in? || expert_signed_in?
      search = Search.find_or_create_by!(query: params[:q]) do |s|
        s.expert_id = current_expert&.id
        s.user_id = current_user&.id
      end

      search.touch
  end

  def wildcard_query
    {
      bool: {
        should: %w[name properties marketplace].map do |field|
          { wildcard: { field => "*#{params[:q]}*" } }
        end
      }
    }
  end

  def redirect_to_last_page
    redirect_to action: 'search', q: params[:q]
  end

  def set_wine
    @wine = Wine.find(params[:id])
  end

  def wine_params
    params.require(:wine).permit(:note)
  end
end
