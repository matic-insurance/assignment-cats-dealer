require 'rails_helper'
require 'nokogiri'

describe Parser::XmlParser do
  describe '.parse_body' do
    it 'parses an XML string into a Nokogiri XML document' do
      xml_string = '<cats><cat><title>Bengal</title><cost>700</cost><location>Rivne</location><img>image_url</img></cat></cats>'
      parsed_doc = described_class.parse_body(xml_string)
      expect(parsed_doc).to be_a(Nokogiri::XML::Document)
      expect(parsed_doc.xpath('//cat/title').text).to eq('Bengal')
    end
  end

  describe '.consolidate_keys' do
    it 'transforms XML nodes into a hash with the expected keys and values' do
      xml_string = '<cats><cat><title>Bengal</title><cost>700</cost><location>Rivne</location><img>image_url</img></cat></cats>'
      parsed_doc = Nokogiri::XML(xml_string)
      expected_result = [
        {
          Parser::BaseParser::CAT_TYPE_KEY => 'Bengal',
          Parser::BaseParser::PRICE_KEY => 700,
          Parser::BaseParser::LOCATION_KEY => 'Rivne',
          Parser::BaseParser::IMAGE_KEY => 'image_url'
        }
      ]
      expect(described_class.consolidate_keys(parsed_doc)).to eq(expected_result)
    end

    it 'correctly handles multiple cat nodes' do
      xml_string = '<cats><cat><title>Bengal</title><cost>700</cost><location>Rivne</location><img>image_url</img></cat><cat><title>Bobtail</title><cost>349</cost><location>Kyiv</location><img>image_url2</img></cat></cats>'
      parsed_doc = Nokogiri::XML(xml_string)
      expected_result = [
        {
          Parser::BaseParser::CAT_TYPE_KEY => 'Bengal',
          Parser::BaseParser::PRICE_KEY => 700,
          Parser::BaseParser::LOCATION_KEY => 'Rivne',
          Parser::BaseParser::IMAGE_KEY => 'image_url'
        },
        {
          Parser::BaseParser::CAT_TYPE_KEY => 'Bobtail',
          Parser::BaseParser::PRICE_KEY => 349,
          Parser::BaseParser::LOCATION_KEY => 'Kyiv',
          Parser::BaseParser::IMAGE_KEY => 'image_url2'
        }
      ]
      expect(described_class.consolidate_keys(parsed_doc)).to eq(expected_result)
    end
  end
end
