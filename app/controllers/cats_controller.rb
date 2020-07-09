class CatsController < ApplicationController
  def new; end

  def best_deal
    response = SearchRequest.search(search_params)
    
  end

  private

  def search_params
    params.permit(:cat_type, :user_location)
  end
end
