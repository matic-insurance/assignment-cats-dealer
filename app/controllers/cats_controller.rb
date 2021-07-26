class CatsController < ApplicationController
  def index
    location = cat_params[:location]
    breed = cat_params[:breed]

    all_cats = CatsFetcher.new.call
    cats = CatsFilter.new.call(all_cats, location: location, breed: breed)

    render json: cats, status: :ok
  end

  def cat_params
    params.permit(:breed, :location)
  end
end
