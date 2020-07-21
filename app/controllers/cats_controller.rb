class CatsController < ApplicationController
  def search
    @cats = CatsDealer.search(SearchRequest.new(search_params))

    @user_location = params.fetch('user_location', nil)
    @breed = params.fetch('breed', nil)
    @searched = true

    render 'index'
  end

  private

  def search_params
    params.permit(:breed, :user_location)
  end
end
