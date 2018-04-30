require 'rails_helper'
require 'providers/parsers/generic_json'

describe Providers::Parsers::GenericJSON do
  subject(:json_parser) { described_class.new }

  let(:response_body) do
    '[{"name":"Abyssin","price":500,"location":"Lviv","image":"https://dummy.com/image.png"}]'
  end

  let(:expected_parsed_hash) do
    [{
      name: 'Abyssin',
      price: 500,
      location: 'Lviv',
      image: 'https://dummy.com/image.png'
    }]
  end

  describe '#parse' do
    it 'returns properly parsed response body' do
      parsed_result = json_parser.parse(response_body)
      expect(parsed_result).to eq(expected_parsed_hash)
    end

    context 'for inconsistent input' do
      let(:badly_formed_json) { '1423 - abc' }

      it 'does not fail and returns empty results' do
        returned_value = json_parser.parse(badly_formed_json)
        expect(returned_value).to match([])
      end

      it 'logs an error' do
        expect(Rails.logger).to receive(:error).with(/^\[Parsers::GenericJSON\] Unable to parse response/i)
        json_parser.parse(badly_formed_json)
      end
    end
  end

  describe '#empty_result' do
    it 'returns empty array' do
      returned_value = json_parser.send(:empty_result)
      expect(returned_value).to match([])
    end
  end
end
