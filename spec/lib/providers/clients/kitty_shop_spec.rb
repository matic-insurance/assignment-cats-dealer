require 'rails_helper'
require 'providers/clients/kitty_shop'
require 'providers/parsers/generic_xml'

describe Providers::Clients::KittyShop do
  subject(:kitty_client) { described_class.new }

  let(:dummy_host) { 'https://external-rosurce.com/' }
  let(:client_env_name) { 'KITTY_SHOP_HOST' }

  before do
    stub_env(client_env_name, dummy_host)
  end

  describe '#parser' do
    it 'returns an instance of XML parser' do
      returned_parser = kitty_client.send(:parser)
      expect(returned_parser).to be_an_instance_of(Providers::Parsers::GenericXML)
    end
  end

  describe '#hostname' do
    it 'returns client host from ENVs' do
      returned_host = kitty_client.send(:hostname)
      expect(returned_host).to eq(dummy_host)
    end

    it 'fails if host is not set in ENVs' do
      without_env(client_env_name) do
        expect { kitty_client.send(:hostname) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#path' do
    let(:client_api_path) { 'dev/cats/xml' }

    it 'returns predefined client API path' do
      returned_path = kitty_client.send(:path)
      expect(returned_path).to eq(client_api_path)
    end
  end
end
