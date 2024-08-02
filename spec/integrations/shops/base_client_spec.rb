require 'rails_helper'
require 'faraday'

describe Integration::Shops::BaseClient do
  let(:shop_url) { 'http://example.com/shop' }
  let(:response) { instance_double(Faraday::Response, body: 'response_body') }
  # let(:connection) { instance_double(Faraday::Connection, get: response) }
  let(:client) { described_class.new }

  before do
    stub_const("#{described_class}::SHOP_URL", shop_url)
    allow(Faraday).to receive(:new).and_call_original
    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)
  end

  describe '#initialize' do
    it 'initializes a Faraday connection with async_http adapter' do
      connection = client.instance_variable_get(:@connection)
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe '.fetch' do
    it 'creates a new instance and calls fetch_records' do
      allow_any_instance_of(described_class).to receive(:fetch_records).and_return('records')
      expect(described_class.fetch).to eq('records')
    end
  end

  describe '#fetch_records' do
    it 'calls make_request with SHOP_URL' do
      expect(client).to receive(:make_request).with(shop_url)
      client.fetch_records
    end
  end

  describe '#make_request' do
    context 'when the request is successful' do
      it 'parses the response' do
        allow(client).to receive(:parse_response).with(response).and_return('parsed_response')
        expect(client.make_request(shop_url)).to eq('parsed_response')
      end
    end

    context 'when a Faraday::Error is raised' do
      it 'logs the error and returns an empty array' do
        allow(client).to receive(:parse_response).and_raise(Faraday::Error,
                                                            'connection failed')
        expect(Rails.logger).to receive(:error).with("Error fetching data from #{shop_url}: connection failed")
        expect(client.make_request(shop_url)).to eq([])
      end
    end
  end

  describe '#parse_response' do
    it 'raises NotImplementedError' do
      expect do
        client.parse_response(response)
      end.to raise_error(NotImplementedError, /cannot respond to/)
    end
  end
end
