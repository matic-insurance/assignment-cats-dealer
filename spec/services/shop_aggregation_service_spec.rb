require 'rails_helper'
require 'shops_aggregation_service'

describe ShopsAggregationService do

  context 'calling products with one shop' do
    it 'should call shop.products' do
      shop = spy('shop')
      shop_aggregator = ShopsAggregationService.new([:any_shop_config])
      allow(shop_aggregator).to receive(:shop).and_return(shop)
      shop_aggregator.products
      expect(shop).to have_received(:products)
    end

    it 'should call join and value for one config' do
      thread = spy('Thread')
      shop_aggregator = ShopsAggregationService.new([:any_shop_config])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:join)
      expect(thread).to have_received(:value)
    end
  end

  context 'calling products with 2 shops' do
    it 'should call shop.products 2 times' do
      shop = spy('shop')
      shop_aggregator = ShopsAggregationService.new([:first_config, :second_config])
      allow(shop_aggregator).to receive(:shop).and_return(shop)
      shop_aggregator.products
      expect(shop).to have_received(:products).twice
    end

    it 'should call get_products for each shop' do
      thread = spy('Thread')
      shop_aggregator = ShopsAggregationService.new([:any_shop_config, :second_config])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:join).twice
      expect(thread).to have_received(:value).twice
    end

  context 'passing invalid shop_config' do
    it 'should raise Type error' do
      shop_aggregator = ShopsAggregationService.new([:first_config])
      expect{shop_aggregator.products}.to raise_error(TypeError)
    end

    it 'should call get_products for each shop' do
      shop_aggregator = ShopsAggregationService.new([:any_shop_config, :second_config])
      shop_aggregator.products
      expect(thread).to have_received(:join).twice
      expect(thread).to have_received(:value).twice
    end
    end
  end
end