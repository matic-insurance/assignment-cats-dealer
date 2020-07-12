class CatsController < ApplicationController
  def new; end

  def search
    cats = CatsDealer.search(SearchRequest.new(search_params))
    redirect_to cats_path(
      cats: cats,
      cat_type: search_params[:cat_type],
      user_location: search_params[:user_location]
    )
  end

  def index
    @cats = params.fetch('cats', [])
    @cat_type = params.fetch('cat_type', nil)
    @user_location = params.fetch('user_location', nil)
  end

  private

  def search_params
    params.permit(:cat_type, :user_location)
  end
end
