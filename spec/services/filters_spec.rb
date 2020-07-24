require 'rails_helper'

describe Filters do
  let(:search_request) { instance_double('SearchRequest', breed: 'Sphynx', user_location: 'Lviv') }

  context 'when filtering deals' do
    it 'perform generic filtering by location, breed and lowest price' do
      cat = build_stubbed(:cat, breed: 'Sphynx', location: 'Lviv', price: 400)
      cheapest_cat = build_stubbed(:cat, breed: 'Sphynx', location: 'Lviv', price: 300)
      deals = [cat, cheapest_cat]

      cheapest_deal = described_class.new(deals, search_request).execute
      expect(cheapest_deal).to eq([cheapest_cat])
    end

    it 'filter by location' do
      cat_from_kyiv = build_stubbed(:cat, breed: 'Sphynx', location: 'Kyiv', price: 500)
      cat_from_lviv = build_stubbed(:cat, breed: 'Sphynx', location: 'Lviv', price: 400)
      deals = [cat_from_lviv, cat_from_kyiv]

      deals_from_lviv = described_class.new(deals, search_request).send(:filter_by_location!)
      expect(deals_from_lviv).to eq([cat_from_lviv])
    end

    it 'filter by breed' do
      sphynx_cat = build_stubbed(:cat, breed: 'Sphynx', location: 'Lviv', price: 500)
      bobtail_cat = build_stubbed(:cat, breed: 'Bobtail', location: 'Lviv', price: 300)
      deals = [sphynx_cat, bobtail_cat]

      sphynx_deals = described_class.new(deals, search_request).send(:filter_by_breed!)
      expect(sphynx_deals).to eq([sphynx_cat])
    end

    it 'filter by lowest price' do
      expensive_cat = build_stubbed(:cat, breed: 'Sphynx', location: 'Lviv', price: 1000)
      cheapest_cat = build_stubbed(:cat, breed: 'Sphynx', location: 'Lviv', price: 300)
      deals = [expensive_cat, cheapest_cat]

      expect(described_class.new(deals).send(:filter_by_lowest_price!)).to eq([cheapest_cat])
    end
  end
end
