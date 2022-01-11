require 'rails_helper'

describe CatsDealers::FetchService do
  let(:expected_count) { 21 }

  describe '#call' do
    it 'returns all cats fetched from dealers' do
      VCR.use_cassette('cat_dealers/cats_unlimited_full_list') do
        VCR.use_cassette('cat_dealers/happy_cats_full_list') do
          collection = described_class.call

          expect(collection.length).to eq(expected_count)
        end
      end
    end

    it 'returns each item as hash object' do
      VCR.use_cassette('cat_dealers/cats_unlimited_full_list') do
        VCR.use_cassette('cat_dealers/happy_cats_full_list') do
          collection = described_class.call

          expect(collection.sample).to be_a(Hash)
        end
      end
    end
  end
end
