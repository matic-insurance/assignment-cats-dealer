class CatsController < ApplicationController
  def search
    cats = CatsDealer.search(SearchRequest.new(search_params))
    redirect_to cats_path(
      cats: cats,
      breed: search_params[:breed],
      user_location: search_params[:user_location],
      searched: true
    )
  end

  def index
    @cats = params.fetch('cats', [])
    @breed = params.fetch('breed', nil)
    @user_location = params.fetch('user_location', nil)
    @searched = params.fetch('searched', nil)
  end

  private

  def search_params
    params.permit(:breed, :user_location)
  end
end
