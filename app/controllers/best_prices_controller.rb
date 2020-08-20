class BestPricesController < ApplicationController
  def new
    @breeds = best_price.get_cats_breeds
    @locations = best_price.get_cats_locations
  end

  def show
    @cats_list = best_price.get_best_price_cat(params[:breed], params[:location])
  end

  def create
    redirect_to best_prices_path(permit_params)
  end

  private

  def best_price
    @best_price ||= CatsDealer::BestPrice.new
  end

  def permit_params
    params.permit(:breed, :location)
  end
end
