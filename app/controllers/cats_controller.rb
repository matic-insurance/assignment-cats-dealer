class CatsController < ApplicationController
  def new; end

  def best_deal
    search = SearchRequest.search(search_params)
    search.response
  end

  private

  def search_params
    params.permit(:cat_type, :user_location)
  end
end
