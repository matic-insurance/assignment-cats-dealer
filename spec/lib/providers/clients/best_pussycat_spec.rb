require 'rails_helper'
require 'providers/clients/best_pussycat'
require 'providers/parsers/generic_json'

describe Providers::Clients::BestPussycat do
  subject(:pussycat_client) { described_class.new }

  let(:dummy_host) { 'https://external-rosurce.com/' }
  let(:client_env_name) { 'BEST_PUSSYCAT_HOST' }

  before do
    stub_env(client_env_name, dummy_host)
  end

  describe '#parser' do
    it 'returns an instance of JSON parser' do
      returned_parser = pussycat_client.send(:parser)
      expect(returned_parser).to be_an_instance_of(Providers::Parsers::GenericJSON)
    end
  end

  describe '#hostname' do
    it 'returns client host from ENVs' do
      returned_host = pussycat_client.send(:hostname)
      expect(returned_host).to eq(dummy_host)
    end

    it 'fails if host is not set in ENVs' do
      without_env(client_env_name) do
        expect { pussycat_client.send(:hostname) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#path' do
    let(:client_api_path) { 'dev/cats/json' }

    it 'returns predefined client API path' do
      returned_path = pussycat_client.send(:path)
      expect(returned_path).to eq(client_api_path)
    end
  end
end
