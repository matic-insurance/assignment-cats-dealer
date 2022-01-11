require 'rails_helper'

describe CatsDealers::Adapters::CatsUnlimited do
  subject(:cats_unlimited_adapter) { described_class }

  let(:expected_item_atttributes) { %i[breed price location image] }

  describe '#list' do
    it 'fetches cats from dealer' do
      VCR.use_cassette('cat_dealers/cats_unlimited_full_list') do
        cats = cats_unlimited_adapter.list
        expect(cats).to be_an(Array)
      end
    end

    it 'builds proper attributes structure for each item from list' do
      VCR.use_cassette('cat_dealers/cats_unlimited_full_list') do
        cats = cats_unlimited_adapter.list
        expect(cats.sample.keys).to eq(expected_item_atttributes)
      end
    end
  end
end
