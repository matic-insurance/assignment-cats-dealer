class CatsController < ApplicationController
  def index
    location = cat_params[:location]
    if location == 'undefined'
      render json: [], status: :ok
    else
      result = CatsFinder.new.call
      render json: result, status: :ok
    end
  end

  def cat_params
    params.permit(:breed, :location, :price)
  end
end
