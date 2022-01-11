require 'rails_helper'

describe CatsDealers::Parsers::Xml do
  subject(:xml_parser) { described_class.new }

  let(:response_body) do
    '<?xml version="1.0" encoding="UTF-8"?>
      <cats>
        <cat>
          <title>American</title>
          <cost>650</cost>
          <location>Odessa</location>
          <img>https://test.com/american.jpg</img>
      </cat>
    </cats>'
  end

  let(:expected_parsed_hash) do
    {
      cats: {
        cat: {
          title: 'American',
          cost: '650',
          location: 'Odessa',
          img: 'https://test.com/american.jpg'
        }
      }
    }
  end

  describe '#parse' do
    it 'returns properly parsed response body' do
      parsed_result = xml_parser.parse(response_body)
      expect(parsed_result).to eq(expected_parsed_hash)
    end

    context 'when inconsistent input' do
      let(:inconsistent_xml_input) { 'Something went wrong>' }

      it 'does not fail and returns empty result' do
        returned_value = xml_parser.parse(inconsistent_xml_input)
        expect(returned_value).to match({})
      end
    end
  end
end
