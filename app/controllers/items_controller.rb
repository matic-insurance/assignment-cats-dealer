class ItemsController < ApplicationController
  def index
    @items = filter_items
    @breeds = Breed.all
    @cities = City.all
  end

  private

  def filter_items
    scope = Item.active
    scope = scope.where(breed_id: params[:breed]) if params[:breed]
    scope = scope.where(city_id: params[:city]) if params[:city]
    scope.order(price_cents: :asc).all
  end
end
