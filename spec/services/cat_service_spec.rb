# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatService do
  let(:fetcher_cats_unlimited) { instance_double(Fetchers::CatsUnlimitedFetcher) }
  let(:fetcher_happy_cats) { instance_double(Fetchers::HappyCatsFetcher) }
  let(:cat_bengal) { Types::Cat.new('Bengal', 500, 'Odessa', 'bengal.jpg') }
  let(:cat_siamese) { Types::Cat.new('Siamese', 300, 'Kyiv', 'siamese.jpg') }
  let(:cat_persian) { Types::Cat.new('Persian', 200, 'Lviv', 'persian.jpg') }

  let(:service) { described_class.new([fetcher_cats_unlimited, fetcher_happy_cats]) }

  describe '#fetch_all_cats' do
    it 'returns all cats from all fetchers' do
      allow(fetcher_cats_unlimited).to receive(:fetch).and_return([cat_bengal, cat_siamese])
      allow(fetcher_happy_cats).to receive(:fetch).and_return([cat_persian])

      result = service.fetch_all_cats

      expect(result).to contain_exactly(cat_bengal, cat_siamese, cat_persian)
    end

    it 'returns an empty array if all fetchers return empty arrays' do
      allow(fetcher_cats_unlimited).to receive(:fetch).and_return([])
      allow(fetcher_happy_cats).to receive(:fetch).and_return([])

      result = service.fetch_all_cats

      expect(result).to eq([])
    end
  end

  describe '#find_best_deal' do
    it 'returns the cat with the lowest price' do
      allow(service).to receive(:fetch_all_cats).and_return([cat_bengal, cat_siamese, cat_persian])

      best_deal = service.find_best_deal

      expect(best_deal).to eq(cat_persian) # Persian cat is the cheapest
    end

    it 'returns nil if there are no cats' do
      allow(service).to receive(:fetch_all_cats).and_return([])

      best_deal = service.find_best_deal

      expect(best_deal).to be_nil
    end
  end
end
