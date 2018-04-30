require 'rails_helper'
require 'providers/parsers/generic_xml'

describe Providers::Parsers::GenericXML do
  subject(:xml_parser) { described_class.new }

  let(:response_body) do
    '<?xml version="1.0" encoding="UTF-8"?><cats><cat><title>American</title><cost>650</cost>'\
      '<location>Odessa</location><img>https://dummy.com/image.png</img></cat></cats>'
  end

  let(:expected_parsed_hash) do
    {
      cats: {
        cat: {
          title: 'American',
          cost: '650',
          location: 'Odessa',
          img: 'https://dummy.com/image.png'
        }
      }
    }
  end

  describe '#parse' do
    it 'returns properly parsed response body' do
      parsed_result = xml_parser.parse(response_body)
      expect(parsed_result).to eq(expected_parsed_hash)
    end

    context 'for inconsistent input' do
      let(:badly_formed_xml) { '1423 - abc' }

      it 'does not fail and returns empty results' do
        returned_value = xml_parser.parse(badly_formed_xml)
        expect(returned_value).to match({})
      end

      it 'logs an error' do
        expect(Rails.logger).to receive(:error).with(/^\[Parsers::GenericXML\] Unable to parse response/i)
        xml_parser.parse(badly_formed_xml)
      end
    end
  end

  describe '#empty_result' do
    it 'returns empty hash' do
      returned_value = xml_parser.send(:empty_result)
      expect(returned_value).to match({})
    end
  end
end
