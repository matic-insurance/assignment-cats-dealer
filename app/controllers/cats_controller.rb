class CatsController < ApplicationController
  def index
    location = cat_params[:location]
    if location == 'undefined'
      render json: [], status: :ok
    else
      result = CatsUnlimitedAdapter.new.fetch_all
      render json: result, status: :ok
    end
  end

  def cat_params
    params.permit(:name, :location, :price)
  end
end
