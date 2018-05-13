require_relative '../models/shop'

class ShopsAggregationService

  def initialize(shop_configs)
    @shop_configs = shop_configs
  end

  def products
    aggregated
  end

  def aggregated
    @aggregated ||= begin
      threads = []
      @shop_configs.each { |shop_config|
        threads << Thread.new {
          shop = Shop.new(shop_config)
          shop.products
        }
      }
      threads.map(&:join).map(&:value).flatten
    end
  end
end