require 'rails_helper'
require 'rest-client'
require 'json'
require 'nokogiri'
require_relative '../../lib/shop_connector'

describe ShopConnector do
  let(:json_url) { ENV.fetch('UNLIMITED_CATS_ENDPOINT', 'https://example.com/cats/json') }
  let(:xml_url) { ENV.fetch('HAPPY_CATS_ENDPOINT', 'https://example.com/cats/xml') }
  let(:json_response) { File.read(Rails.root.join('spec/fixtures/cats_unlimited/response.json')) }
  let(:xml_response) { File.read(Rails.root.join('spec/fixtures/happy_cats/response.xml')) }

  describe '#fetch_cats' do
    context 'when response format is JSON' do
      let(:connector) { described_class.new(json_url, :json) }

      it 'parses the JSON response correctly' do
        allow(RestClient).to receive(:get).with(json_url).and_return(double(body: json_response))
        result = connector.fetch_cats
        expect(result).to eq({
                               'cats' => [
                                 {
                                   'image' => 'https://olxua-ring10.akamaized.net/images_slandocomua/some1.jpg',
                                   'location' => 'Rivne',
                                   'cat_type' => 'Bengal',
                                   'price' => 700
                                 },
                                 {
                                   'image' => 'https://olxua-ring09.akamaized.net/images_slandocomua/some2.jpg',
                                   'location' => 'Kharkiv',
                                   'cat_type' => 'Bobtail',
                                   'price' => 349
                                 },
                                 {
                                   'image' => 'https://olxua-ring09.akamaized.net/images_slandocomua/some3.jpg',
                                   'location' => 'Kyiv',
                                   'cat_type' => 'British Shorthair',
                                   'price' => 350
                                 }
                               ]
                             })
      end
    end

    context 'when response format is XML' do
      let(:connector) { described_class.new(xml_url, :xml) }

      it 'parses the XML response correctly' do
        allow(RestClient).to receive(:get).with(xml_url).and_return(double(body: xml_response))
        result = connector.fetch_cats
        expect(result).to eq({
                               'cats' => [
                                 {
                                   'cat_type' => 'American Curl',
                                   'image' => 'https://olxua-ring07.akamaized',
                                   'location' => 'Kharkiv',
                                   'price' => 350
                                 },
                                 {
                                   'cat_type' => 'Bengal',
                                   'image' => 'https://olxua-ring01.akamaized.net/images_slandocomua/some.jpg',
                                   'location' => 'Rivne',
                                   'price' => 100
                                 },
                                 {
                                   'cat_type' => 'Bengal',
                                   'image' => 'https://olxua-ring10.akamaized.net/images_slandocomua/some1.jpg',
                                   'location' => 'Kyiv',
                                   'price' => 600
                                 },
                                 {
                                   'cat_type' => 'Bobtail',
                                   'image' => 'https://olxua-ring09.akamaized.net/images_slandocomua/some3.jpg',
                                   'location' => 'Kyiv',
                                   'price' => 369
                                 }
                               ]

                             })
      end
    end

    context 'when an error occurs' do
      context 'RestClient::ExceptionWithResponse error' do
        let(:connector) { described_class.new(json_url, :json) }

        it 'returns an error response' do
          allow(RestClient).to receive(:get).with(json_url).and_raise(RestClient::ExceptionWithResponse.new(double))
          result = connector.fetch_cats
          expect(result).to have_key(:error)
        end
      end
      context 'JSON::ParserError error' do
        let(:connector) { described_class.new(json_url, :json) }

        it 'returns an error response' do
          allow(RestClient).to receive(:get).with(json_url).and_return(double(body: 'invalid json'))
          result = connector.fetch_cats
          expect(result).to have_key(:error)
        end
      end

      context 'Nokogiri::XML::SyntaxError error' do
        let(:connector) { described_class.new(xml_url, :xml) }

        it 'returns an error response' do
          allow(RestClient).to receive(:get).with(xml_url).and_raise(Nokogiri::XML::SyntaxError)
          result = connector.fetch_cats
          expect(result).to have_key(:error)
        end
      end

      context 'unexpected error' do
        let(:connector) { described_class.new(xml_url, :xml) }

        it 'returns an error response' do
          allow(RestClient).to receive(:get).with(xml_url).and_raise(StandardError)
          result = connector.fetch_cats
          expect(result).to have_key(:error)
        end
      end
    end
  end
end
