require 'rails_helper'

describe Shops::CatsBaseService do
  let(:service) { described_class.new }
  let(:shop_name) { 'CatsHappy' }
  let(:cache_key) { 'test_key' }
  let(:response) { [{name: 'American Curl', price: 144}] }
  let(:transformed_response) { [{name: 'American Curl', price: 144, shop_name:}] }

  before do
    stub_const("#{described_class}::SHOP_NAME", shop_name)
    stub_const("#{described_class}::CACHE_KEY", cache_key)
  end

  describe '#call' do
    context 'when data is cached' do
      it 'fetches data from cache' do
        allow(Rails.cache).to receive(:read).with(cache_key).and_return(transformed_response)
        expect(service.call).to eq(transformed_response)
      end
    end

    context 'when data is not cached' do
      before do
        allow(Rails.cache).to receive(:read).with(cache_key).and_return(nil)
        allow(service).to receive(:fetch_from_api).and_return(transformed_response)
      end

      it 'fetches data from API' do
        expect(service.call).to eq(transformed_response)
      end
    end
  end

  describe '#transform_response' do
    it 'transforms response using the appropriate adapter' do
      adapter_instance = instance_double("Shops::#{shop_name}Adapter")
      allow("Shops::#{shop_name}Adapter".constantize).to receive(:new).and_return(adapter_instance)
      expect(adapter_instance).to receive(:adapt).with(response).and_return(transformed_response)

      expect(service.send(:transform_response, response)).to eq(transformed_response)
    end
  end

  describe '#fetch_from_api' do
    before do
      allow("Integration::Shops::#{shop_name}".constantize).to receive(:fetch).and_return(response)
      allow_any_instance_of("Shops::#{shop_name}Adapter".constantize).to receive(:adapt).and_return(transformed_response)
    end

    it 'fetches data from API and writes to cache' do
      expect(Rails.cache).to receive(:write).with(cache_key, transformed_response,
                                                  expires_in: described_class::CACHE_EXPIRES_IN)
      expect(service.send(:fetch_from_api)).to eq(transformed_response)
    end
  end

  describe '#fetch_from_cache' do
    it 'reads data from cache' do
      expect(Rails.cache).to receive(:read).with(cache_key)
      service.send(:fetch_from_cache)
    end
  end

  describe '#shop_name' do
    it 'returns the shop name' do
      expect(service.send(:shop_name)).to eq(shop_name)
    end
  end

  describe '#cache_key' do
    it 'returns the cache key' do
      expect(service.send(:cache_key)).to eq(cache_key)
    end
  end
end
