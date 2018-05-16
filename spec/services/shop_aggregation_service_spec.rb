require 'rails_helper'
require 'shops_aggregation_service'
require 'integrations/shops/happy_cats_config'

describe ShopsAggregationService do
  context 'calling products with one shop' do
    it 'calls shop.products' do
      shop = spy('shop')
      shop_aggregator = described_class.new([:any_shop_config])
      allow(shop_aggregator).to receive(:shop).and_return(shop)
      shop_aggregator.products
      expect(shop).to have_received(:products)
    end

    it 'calls join for one config' do
      thread = spy('Thread')
      shop_aggregator = described_class.new([HappyCatsConfig])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:join)

    end
    it 'calls value for one config' do
      thread = spy('Thread')
      shop_aggregator = described_class.new([HappyCatsConfig])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:value)
    end
  end

  context 'when calling products with 2 shops' do
    it 'calls shop.products 2 times' do
      shop = spy('shop')
      shop_aggregator = described_class.new(%i[first_config second_config])
      allow(shop_aggregator).to receive(:shop).and_return(shop)
      shop_aggregator.products
      expect(shop).to have_received(:products).twice
    end

    it 'calls join for each shop' do
      thread = spy('Thread')
      shop_aggregator = described_class.new([HappyCatsConfig, HappyCatsConfig])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:join).twice
    end

    it 'calls value for each shop' do
      thread = spy('Thread')
      shop_aggregator = described_class.new([HappyCatsConfig, HappyCatsConfig])
      allow(shop_aggregator).to receive(:get_products).and_return(thread)
      shop_aggregator.products
      expect(thread).to have_received(:value).twice
    end
  end

  context 'when passed invalid shop_config' do
    it 'raises Type error' do
      shop_aggregator = described_class.new([:first_config])
      expect { shop_aggregator.products }.to raise_error(NoMethodError)
    end
  end

  context 'when called shop' do
    it 'returns shop instance' do
      shop_aggregator = described_class.new([])
      expect(shop_aggregator.shop(HappyCatsConfig)).to be_a(Shop)
    end
  end

  context 'when called shops' do
    it 'returns and array of shops' do
      shop_aggregator = described_class.new([])
      expect(shop_aggregator.shops.first).to be_a(Shop)
    end
  end
end
