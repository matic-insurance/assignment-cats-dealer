require 'rails_helper'
require 'cats_aggregation_service'


describe CatsAggregationService do

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
  it 'should be a kind of ProductAggregationService' do
    aggregated_products = CatsAggregationService.new(products)
    expect(aggregated_products).to be_a ProductAggregationService
  end

  context 'allowed query params' do
    it 'should return allowed params' do
      aggregated_products = CatsAggregationService.new(products)
      expect(aggregated_products.allowed_query_params).to eq [{:location=>[]}, {:shop=>[]}, {:breed=>[]}]
    end
  end

  context 'filter options' do
    before do
      @aggregated_products = CatsAggregationService.new(products)
      allow(@aggregated_products).to receive(:locations).and_return(%w(a c b))
      allow(@aggregated_products).to receive(:shops).and_return(%w(c a b))
      allow(@aggregated_products).to receive(:breeds).and_return(%w(c a b))
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

    it 'should return sorted breeds' do
      expect(@aggregated_products.filter_options[:breeds]).to eq %w(a b c)
    end
  end
end
