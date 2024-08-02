require 'rails_helper'

describe Shops::CatsUnlimitedService do
  let(:service) { described_class.new }

  describe '.SHOP_NAME' do
    it 'returns the correct shop name' do
      expect(described_class::SHOP_NAME).to eq('CatsUnlimited')
    end
  end

  describe '.CACHE_KEY' do
    it 'returns the correct cache key' do
      expect(described_class::CACHE_KEY).to eq('cats_unlimited')
    end
  end
end
