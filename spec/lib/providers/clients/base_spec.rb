require 'rails_helper'
require 'providers/clients/base'

describe Providers::Clients::Base do
  subject(:base_client) { described_class.new }

  let(:dummy_host) { 'https://external-rosurce.com/' }
  let(:stub_hostname) { allow_any_instance_of(described_class).to receive(:hostname).and_return(dummy_host) }

  context 'as implemented methods' do
    let(:dummy_path) { 'api/v1/resource' }
    let(:expected_parsed_response) do
      [
        {
          breed: 'Juicy',
          price: 600,
          location: 'Lviv',
          picture_url: dummy_host
        }
      ]
    end

    before do
      stub_hostname
      allow(base_client).to receive(:path).and_return(dummy_path)
    end

    describe '#new' do
      it 'instantiates http connection based on the host' do
        http_connection = base_client.instance_variable_get(:@http_connection)

        expect(http_connection).to be_instance_of(Faraday::Connection)
        expect(http_connection.url_prefix.to_s).to eq(dummy_host)
        expect(base_client).to have_received(:hostname)
      end
    end

    describe '#get' do
      let(:dummy_response) { double('http', body: 'key: value') }
      let(:dummy_parser) { double('parser') }

      before do
        http_connection = base_client.instance_variable_get(:@http_connection)

        allow(http_connection).to receive(:get).with(dummy_path, {}).and_return(dummy_response)
        allow(dummy_parser).to receive(:parse).with(dummy_response.body).and_return(expected_parsed_response)
        allow(base_client).to receive(:parser).and_return(dummy_parser)
      end

      it 'sends GET request' do
        base_client.get
        expect(base_client).to have_received(:path)
        expect(dummy_parser).to have_received(:parse)
      end

      it 'accepts optional payload' do
        optional_params = {param: :value}
        http_connection = base_client.instance_variable_get(:@http_connection)
        allow(http_connection).to receive(:get).with(dummy_path, optional_params).and_return(dummy_response)

        base_client.get
        expect(http_connection).to have_received(:get)
      end

      it 'returns parsed response body' do
        expect(base_client.get).to eq(expected_parsed_response)
        expect(dummy_parser).to have_received(:parse)
      end
    end
  end

  context 'as not implemented methods' do
    describe '#parser' do
      before { stub_hostname }

      it 'is abstract and fails with error when called' do
        expect { base_client.send(:parser) }
          .to raise_error(NotImplementedError, 'Please implement client specific parser')
      end
    end

    describe '#hostname' do
      it 'is abstract and fails with error when called' do
        expect { base_client.send(:hostname) }.to raise_error(NotImplementedError)
      end
    end

    describe '#path' do
      before { stub_hostname }

      it 'is abstract and fails with error when called' do
        expect { base_client.send(:path) }.to raise_error(NotImplementedError)
      end
    end
  end
end
