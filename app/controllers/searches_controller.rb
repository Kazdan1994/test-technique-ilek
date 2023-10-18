class SearchesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @searches = pagy(Search.limit(5))
  end
end
