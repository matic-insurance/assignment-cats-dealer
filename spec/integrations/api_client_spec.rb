require 'rails_helper'
require 'integrations/clients/api_client'

describe ApiClient do
  context 'fetch' do
    it 'calls client. get' do
      rest_client = spy('client')
      client = described_class.new('some_url', 0, rest_client)
      client.fetch
      expect(rest_client).to have_received(:get).with('some_url').once
    end

    it 'retries in case of error' do
      rest_client = spy('client')
      allow(rest_client).to receive(:get).and_raise(Exception)
      client = described_class.new('some_url', 3, rest_client)
      client.fetch
      expect(rest_client).to have_received(:get).thrice
    end

    it 'returns nil after all retries' do
      rest_client = spy('client')
      allow(rest_client).to receive(:get).and_raise(Exception)
      client = described_class.new('some_url', 1, rest_client)
      expect(client.fetch).to be_nil
    end
  end
end
