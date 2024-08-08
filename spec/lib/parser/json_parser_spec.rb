require 'rails_helper'

describe Parser::JsonParser do
  describe '.parse_body' do
    it 'parses a JSON string into a Ruby hash' do
      json_string = '{"name": "Bengal", "price": 700}'
      expected_result = { 'name' => 'Bengal', 'price' => 700 }
      expect(described_class.parse_body(json_string)).to eq(expected_result)
    end
  end

  describe '.consolidate_keys' do
    it 'transforms keys in a hash according to RELATED_KEYS' do
      parsed_data = { 'name' => 'Bengal', 'price' => 700 }
      expected_result = { Parser::BaseParser::CAT_TYPE_KEY => 'Bengal', Parser::BaseParser::PRICE_KEY => 700 }
      expect(described_class.consolidate_keys(parsed_data)).to eq(expected_result)
    end

    it 'transforms keys in an array of hashes' do
      parsed_data = [
        { 'name' => 'Bengal', 'price' => 700 },
        { 'name' => 'Bobtail', 'price' => 349 }
      ]
      expected_result = [
        { Parser::BaseParser::CAT_TYPE_KEY => 'Bengal', Parser::BaseParser::PRICE_KEY => 700 },
        { Parser::BaseParser::CAT_TYPE_KEY => 'Bobtail', Parser::BaseParser::PRICE_KEY => 349 }
      ]
      expect(described_class.consolidate_keys(parsed_data)).to eq(expected_result)
    end

    it 'leaves unrelated keys unchanged' do
      parsed_data = { 'name' => 'Bengal', 'price' => 700, 'location' => 'Rivne' }
      expected_result = { Parser::BaseParser::CAT_TYPE_KEY => 'Bengal', Parser::BaseParser::PRICE_KEY => 700, Parser::BaseParser::LOCATION_KEY => 'Rivne' }
      expect(described_class.consolidate_keys(parsed_data)).to eq(expected_result)
    end
  end
end
