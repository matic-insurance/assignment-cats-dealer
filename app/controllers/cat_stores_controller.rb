class CatStoresController < ApplicationController
  def new
    @cities = City.pluck(:location)
    @cat_names = CatName.pluck(:name)
  end

  def result
    @cats_list = CatsStore.cats_list(params[:cats_type], params[:user_location])
    @best_price = @cats_list.minimum(:price)
  end
end
