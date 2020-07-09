class CatsController < ApplicationController
  def new; end

  def search
    @cats = SearchRequest.search(search_params)

    result_params = {
      cats_list: @cats,
      cat_type: params[:cats_type],
      location: params[:user_location]
    }

    redirect_to cats_path({cats: @cats}) #TODO fix this.
  end

  def index; end

  def result

  end

  private

  def search_params
    params.permit(:cat_type, :user_location)
  end

end
