class CatsController < ApplicationController
  def search
    @cats = CatsDealer.search(SearchRequest.new(search_params))

    respond_to do |format|
      format.html
      format.json { render json: @cats }
    end
  end
  #
  # def index
  #   @cats = params.fetch('cats', [])
  #   @breed = params.fetch('breed', nil)
  #   @user_location = params.fetch('user_location', nil)
  #   @searched = params.fetch('searched', nil)
  # end

  private

  def search_params
    params.permit(:breed, :user_location)
  end
end
