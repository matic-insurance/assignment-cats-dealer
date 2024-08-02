require 'rails_helper'

describe Shops::CatsHappyAdapter do
  let(:shop_name) { 'Example Shop' }
  let(:adapter) { described_class.new(shop_name:) }

  describe '#mapping' do
    it 'returns the correct mapping' do
      expected_mapping = {
        name: :title,
        price: :cost,
        location: :location,
        image: :img
      }

      expect(adapter.send(:mapping)).to eq(expected_mapping)
    end
  end

  describe '#adapt' do
    let(:expected_keys) { %i[name price location image shop_name] }

    it 'returns formatted items according to mappings' do
      VCR.use_cassette('cats_happy_response') do
        response = Integration::Shops::CatsHappy.fetch
        formatted_items = adapter.adapt(response)

        expect(formatted_items).to all(include(*expected_keys))
      end
    end
  end
end
