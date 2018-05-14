require_relative '../models/shop'

class ShopsAggregationService
  def initialize(shop_configs)
    @shop_configs = shop_configs
  end

  def products
    @products ||= @shop_configs.map do |shop_config|
        get_products(shop_config)
      end.map(&:join).map(&:value).flatten
  end

  def get_products(shop_config)
    Thread.new do
      shop(shop_config).products
    end
  end

  def shop(shop_config)
    Shop.new(shop_config)
  end
end
