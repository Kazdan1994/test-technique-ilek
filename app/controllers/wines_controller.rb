# Wines controller
class WinesController < ApplicationController
  def index
    @wines = Wine.limit(5)
  end

  def search
    @wines = search_wines
    redirect_to_last_page if @wines.total_pages < params[:page].to_i
  end

  private

  def search_wines
    if params[:q].present?
      search_results.page(params[:page]).per(5)
    else
      Wine.page(params[:page]).per(5)
    end
  end

  def search_results
    Wine.__elasticsearch__.search(query: wildcard_query).records
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
end
