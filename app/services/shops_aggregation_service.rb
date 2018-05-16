require_relative '../models/shop'

class ShopsAggregationService
  def initialize(shop_configs, model = Shop, executor = Thread)
    @shop_configs = shop_configs
    @model = model
    @executor = executor
  end

  def products
    @products ||= shops.map do |shop|
      get_products(shop)
    end.map(&:join).map(&:value).flatten
  end

  def get_products(shop)
    @executor.new do
      shop.products
    end
  end

  def shops
    @shops ||= @shop_configs.map{ |shop_config| shop(shop_config)}
  end

  def shop(shop_config)
    @model.new(shop_config)
  end
end
