class CatsController < ApplicationController
  def new; end

  def search
    cats = CatsDealer.search(SearchRequest.new(search_params))
    redirect_to cats_path(cats: cats)
  end

  def index
    @cats = params['cats'].present? ? params['cats'] : []
  end

  private

  def search_params
    params.permit(:cat_type, :user_location)
  end
end
