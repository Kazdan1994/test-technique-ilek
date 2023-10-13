# Wines controller
class WinesController < ApplicationController
  def index
    @wines = Wine.limit(5)
  end
end
