require 'rails_helper'
require 'providers/adapters/best_pussycat'
require 'providers/clients/base'
require 'providers/clients/best_pussycat'
require 'providers/models/best_pussycat'

describe Providers::Adapters::BestPussycat do
  subject(:pussycat_adapter) { described_class.new }

  let(:expected_cats_count) { 11 }
  let(:pussycat_client_response) do
    [
      {
        name: 'Juicy',
        price: 600,
        location: 'Lviv',
        image: 'https://external-rosurce.com/'
      }, {
        name: 'Abyssin',
        price: 400,
        location: 'Odesa',
        image: 'https://external-rosurce.com/'
      }
    ]
  end

  describe '#fetch_all' do
    it 'fetches and wrap cats from provider' do
      VCR.use_cassette('cat_providers/best_pussycats') do
        cats = pussycat_adapter.fetch_all
        expect(cats).to be_an(Array)
        expect(cats.count).to eq(expected_cats_count)
      end
    end

    it 'returns empty results if no cats were provided' do
      VCR.use_cassette('cat_providers/best_pussycats_empty') do
        cats = pussycat_adapter.fetch_all
        expect(cats).to match([])
      end
    end
  end

  describe '#wrap' do
    let(:pussycat_class) { Providers::Models::BestPussycat }

    it 'takes parsed response and wraps it into BestPussycat models' do
      wrapped_models = pussycat_adapter.send(:wrap, pussycat_client_response)
      expect(wrapped_models).to be_an(Array)
      expect(wrapped_models.sample).to be_an_instance_of(pussycat_class)
      expect(wrapped_models.count).to be(pussycat_client_response.size)
    end
  end

  describe '#client' do
    it 'returns BestPussycat client instance' do
      client = pussycat_adapter.send(:client)
      expect(client).to be_kind_of(Providers::Clients::Base)
      expect(client).to be_an_instance_of(Providers::Clients::BestPussycat)
    end
  end

  describe '#base_model' do
    it 'returns BestPussycat model' do
      model = pussycat_adapter.send(:base_model)
      expect(model).to eq(Providers::Models::BestPussycat)
    end
  end
end
