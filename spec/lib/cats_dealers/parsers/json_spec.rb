require 'rails_helper'

describe CatsDealers::Parsers::Json do
  subject(:json_parser) { described_class.new }

  let(:response_body) do
    '[{"name":"Abyssin","price":500,"location":"Lviv","image":"https://test.com/abyssin.jpg"}]'
  end

  let(:expected_parsed_array) do
    [{name: 'Abyssin', price: 500, location: 'Lviv', image: 'https://test.com/abyssin.jpg'}]
  end

  describe '#parse' do
    it 'returns properly parsed response body' do
      parsed_result = json_parser.parse(response_body)
      expect(parsed_result).to eq(expected_parsed_array)
    end

    context 'when inconsistent input' do
      let(:inconsistent_json_input) { 'Something went wrong>' }

      it 'does not fail and returns empty result' do
        returned_value = json_parser.parse(inconsistent_json_input)
        expect(returned_value).to match([])
      end
    end
  end
end
