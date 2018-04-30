require 'rails_helper'
require 'providers/adapters/kitty_shop'
require 'providers/clients/base'
require 'providers/clients/kitty_shop'
require 'providers/models/kitty_shop'

describe Providers::Adapters::KittyShop do
  subject(:kitty_shop_adapter) { described_class.new }

  let(:expected_cats_count) { 10 }
  let(:kitty_shop_client_response) do
    {
      cats: {
        cat: [{
          title: 'Juicy',
          cost: 600,
          location: 'Lviv',
          img: 'https://external-rosurce.com/'
        }, {
          title: 'Abyssin',
          cost: 400,
          location: 'Odesa',
          img: 'https://external-rosurce.com/'
        }]
      }
    }
  end

  describe '#fetch_all' do
    it 'fetches and wrap cats from provider' do
      VCR.use_cassette('cat_providers/kitty_shop') do
        cats = kitty_shop_adapter.fetch_all
        expect(cats).to be_an(Array)
        expect(cats.count).to eq(expected_cats_count)
      end
    end

    it 'returns empty results if no cats were provided' do
      VCR.use_cassette('cat_providers/kitty_shop_empty') do
        cats = kitty_shop_adapter.fetch_all
        expect(cats).to match([])
      end
    end
  end

  describe '#wrap' do
    let(:kitty_shop_class) { Providers::Models::KittyShop }

    it 'takes parsed response and wraps it into KittyShop models' do
      wrapped_models = kitty_shop_adapter.send(:wrap, kitty_shop_client_response)
      expect(wrapped_models).to be_an(Array)
      expect(wrapped_models.sample).to be_an_instance_of(kitty_shop_class)
      expect(wrapped_models.count).to be(2)
    end
  end

  describe '#client' do
    it 'returns KittyShop client instance' do
      client = kitty_shop_adapter.send(:client)
      expect(client).to be_kind_of(Providers::Clients::Base)
      expect(client).to be_an_instance_of(Providers::Clients::KittyShop)
    end
  end

  describe '#base_model' do
    it 'returns KittyShop model' do
      model = kitty_shop_adapter.send(:base_model)
      expect(model).to eq(Providers::Models::KittyShop)
    end
  end
end
