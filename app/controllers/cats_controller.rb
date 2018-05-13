require 'shops_aggregation_service'
require 'cats_aggregation_service'
require 'integrations/shops/happy_cats_config'
require 'integrations/shops/unlimited_cats_config'

class CatsController < ApplicationController

  def index
    shop_aggregator = ShopsAggregationService.new([HappyCatsConfig, UnlimitedCatsConfig])
    cats_aggregator = CatsAggregationService.new(shop_aggregator.products)
    @search_params  = params.permit(cats_aggregator.allowed_query_params).to_h
    @cats_list      = cats_aggregator.find(@search_params).sort_by(&:price)
    @filter_options = cats_aggregator.filter_options
  end

  def count
    shop_aggregator = ShopsAggregationService.new([HappyCatsConfig, UnlimitedCatsConfig])
    cats_aggregator = CatsAggregationService.new(shop_aggregator.products)
    @search_params  = params.permit(cats_aggregator.allowed_query_params).to_h
    render json: {count: cats_aggregator.count(@search_params)}
  end
end
