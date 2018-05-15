require 'rails_helper'
require 'shops_aggregation_service'

describe ShopsAggregationService do
  context 'calling products with one shop' do
    it 'calls shop.products' do
      shop = spy('shop')
      shop_aggregator = described_class.new([:any_shop_config])
      allow(shop_aggregator).to receive(:shop).and_return(shop)
      shop_aggregator.products
      expect(shop).to have_received(:products)
    end

    it 'calls join and value for one config' do
      thread = spy('Thread')
      shop_aggregator = described_class.new([:any_shop_config])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:join)
      expect(thread).to have_received(:value)
    end
  end

  context 'calling products with 2 shops' do
    it 'calls shop.products 2 times' do
      shop = spy('shop')
      shop_aggregator = described_class.new(%i[first_config second_config])
      allow(shop_aggregator).to receive(:shop).and_return(shop)
      shop_aggregator.products
      expect(shop).to have_received(:products).twice
    end

    it 'calls get_products for each shop' do
      thread = spy('Thread')
      shop_aggregator = described_class.new(%i[any_shop_config second_config])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:join).twice
      expect(thread).to have_received(:value).twice
    end
  end

  context 'passing invalid shop_config' do
    it 'raises Type error' do
      shop_aggregator = described_class.new([:first_config])
      expect { shop_aggregator.products }.to raise_error(NoMethodError)
    end
  end
end
