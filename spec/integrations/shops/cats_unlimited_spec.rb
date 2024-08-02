require 'rails_helper'

describe Integration::Shops::CatsUnlimited do
  let(:shop_url) { described_class::SHOP_URL }
  let(:client) { described_class.new }
  let(:expected_keys) { %i[name price location image] }

  describe '#parse_response' do
    it 'parses the response and returns the cats data', :vcr do
      VCR.use_cassette('cats_unlimited_response') do
        response = Faraday.get(shop_url)

        parsed_response = client.parse_response(response)

        expect(parsed_response).to all(be_a(Hash).and(include(*expected_keys)))
      end
    end
  end
end
