require 'shops_aggregation_service'
require 'product_aggregation_service'
require 'integrations/shops/happy_cats_shop'
require 'integrations/shops/unlimited_cats_shop'

class CatsController < ApplicationController

  def search
    @search_params = params.permit(:location, :breed).to_h
    aggregation_service = ShopsAggregationService.new([HappyCatsShop.new, UnlimitedCatsShop.new])
    product_aggregator = ProductAggregationService.new(aggregation_service.products)
    @locations = product_aggregator.locations.sort
    @breeds = product_aggregator.breeds.sort
    @cats_list = product_aggregator.find_where(@search_params).sort_by(&:price)
  end
end
