require 'rails_helper'
require 'providers/adapters/best_pussycat'
require 'providers/adapters/kitty_shop'
require 'providers/models/kitty_shop'
require 'providers/models/best_pussycat'

describe CatsServices::FetchService, type: :service do
  let(:service) { described_class }
  let(:expected_cats_count) { 21 }

  describe '#all' do
    it 'returns all cats fetched from providers' do
      VCR.use_cassette('cat_providers/best_pussycats') do
        VCR.use_cassette('cat_providers/kitty_shop') do
          all_cats = service.all

          expect(all_cats.sample).to be_a(Cat)
          expect(all_cats.count).to eq(expected_cats_count)
        end
      end
    end

    it 'returns empty array if providers have no cats' do
      VCR.use_cassette('cat_providers/best_pussycats_empty') do
        VCR.use_cassette('cat_providers/kitty_shop_empty') do
          expect(service.all).to match([])
        end
      end
    end
  end

  describe '.concurrent_fetch' do
    let(:providers) do
      [Providers::Adapters::KittyShop, Providers::Adapters::BestPussycat]
    end

    it 'fetches cats from passed providers' do
      VCR.use_cassette('cat_providers/best_pussycats') do
        VCR.use_cassette('cat_providers/kitty_shop') do
          result = service.send(:concurrent_fetch, providers)

          expect(result.flatten.count).to eq(expected_cats_count)
        end
      end
    end
  end

  describe '.wrap' do
    let(:basic_cats) do
      build_list(:best_pussycat, 4) + build_list(:kitty_shop_cat, 3)
    end

    it 'wraps BasicCats into Cat models' do
      cats = service.send(:wrap, basic_cats)

      expect(cats.sample).to be_a(Cat)
      expect(cats.count).to eq(basic_cats.count)
    end
  end
end
