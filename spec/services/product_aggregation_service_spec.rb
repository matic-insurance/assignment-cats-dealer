require 'rails_helper'
require 'product_aggregation_service'

describe ProductAggregationService do

  let(:products) do
    [
      {
      breed: 'breed1',
      location: 'location1',
      price: 1,
      shop: 'shop1',
      image: 'image1'
      },
      {
      breed: 'breed2',
      location: 'location2',
      price: 2,
      shop: 'shop2',
      image: 'image2'
    },
    ].map{|config| Cat.new(config)}
  end

  context 'call products' do
    it 'should return products' do
      aggregated_products = ProductAggregationService.new(products)
      expect(aggregated_products.products).to eq products
    end
  end

  context 'allowed query params' do
    it 'should return allowed params' do
      aggregated_products = ProductAggregationService.new(products)
      expect(aggregated_products.allowed_query_params).to eq [{:location=>[]}, {:shop=>[]}]
    end
  end

  context 'filter options' do
    before do
      @aggregated_products = ProductAggregationService.new(products)
      allow(@aggregated_products).to receive(:locations).and_return(%w(a c b))
      allow(@aggregated_products).to receive(:shops).and_return(%w(c a b))
    end
    it 'should return option hash' do
      expect(@aggregated_products.filter_options).to be_a(Hash)
    end

    it 'should return sorted locations' do
      expect(@aggregated_products.filter_options[:locations]).to eq %w(a b c)
    end

    it 'should return sorted shops' do
      expect(@aggregated_products.filter_options[:shops]).to eq %w(a b c)
    end
  end

  context 'aggregates locations' do
    before do
      @aggregated_products = ProductAggregationService.new(products)
    end
    it 'should collect all locations' do
      expect(@aggregated_products.locations).to eq products.collect(&:location)
    end

    it 'should remove all nil values' do
      @aggregated_products = ProductAggregationService.new(products + [Cat.new({location: nil})])
      expect(@aggregated_products.locations).to eq products.collect(&:location)
    end

    it 'should remove duplicates' do
      @aggregated_products = ProductAggregationService.new(products + [Cat.new({location: 'location1'})])
      expect(@aggregated_products.locations).to eq products.collect(&:location)
    end
  end

  context 'aggregates shops' do
    it 'should collect all values' do
      aggregated_products = ProductAggregationService.new(products)
      expect(aggregated_products.shops).to eq products.collect(&:shop)
    end

    it 'should remove all nil values' do
      aggregated_products = ProductAggregationService.new(products + [Cat.new({shop: nil})])
      expect(aggregated_products.shops).to eq products.collect(&:shop)
    end

    it 'should remove duplicates' do
      aggregated_products = ProductAggregationService.new(products + [Cat.new({shop: 'shop1'})])
      expect(aggregated_products.shops).to eq products.collect(&:shop)
    end
  end

  context 'find' do
    before do
      @aggregated_products = ProductAggregationService.new(products)
    end
    it 'should return all_products' do
      allow(@aggregated_products).to receive(:filter_products).and_return(products)
      expect(@aggregated_products.find({})).to eq products
    end

    it 'should filter_by location' do
      result = @aggregated_products.find({location: ['location1']})
      expect(result.first.location).to eq 'location1'
      expect(result.size).to eq 1
    end

    it 'should find by shop' do
      result = @aggregated_products.find({shop: ['shop1']})
      expect(result.first.shop).to eq 'shop1'
      expect(result.size).to eq 1
    end

    it 'should find by shop and location' do
      expected = [Cat.new({shop: 'shop1', location: 'location2'})]
      @aggregated_products = ProductAggregationService.new(products + expected)
      result = @aggregated_products.find({shop: ['shop1'], location: ['location2']})
      expect(result).to eq expected
    end

    it 'should find by any attr present on a model' do
      expected = [Cat.new({shop: 'shop1', location: 'location2', breed: 'breed4'})]
      @aggregated_products = ProductAggregationService.new(products + expected)
      result = @aggregated_products.find({breed: ['breed4']})
      expect(result).to eq expected
    end
  end

  context 'count' do
    before do
      shops_aggregator = double('shops_aggregator', :products => products)
      @aggregated_products = ProductAggregationService.new(shops_aggregator)
    end

    it 'should call size of filtered_products' do
      array_spy = spy('array')
      allow(@aggregated_products).to receive(:filter_products).and_return(array_spy)
      @aggregated_products.count({})
      expect(array_spy).to have_received(:size)
    end
  end
end
