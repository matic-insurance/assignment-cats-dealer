require 'rails_helper'

describe Shops::CatsHappyService do
  let(:service) { described_class.new }
  let(:shop_name) { 'CatsHappy' }
  let(:cache_key) { 'cats_happy' }

  describe '.SHOP_NAME' do
    it 'returns the correct shop name' do
      expect(described_class::SHOP_NAME).to eq(shop_name)
    end
  end

  describe '.CACHE_KEY' do
    it 'returns the correct cache key' do
      expect(described_class::CACHE_KEY).to eq(cache_key)
    end
  end
end
