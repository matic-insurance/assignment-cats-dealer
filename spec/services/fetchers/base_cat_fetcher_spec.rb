# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fetchers::BaseCatFetcher do
  let(:http_service) { instance_double(HttpService) }
  let(:fetcher_class) do
    Class.new(described_class) do
      self::URL = 'https://example.com'

      private

      def parse(response)
        response
      end
    end
  end
  let(:fetcher) { fetcher_class.new(http_service:) }

  describe '#fetch' do
    context 'when the fetcher successfully fetches data' do
      before do
        allow(http_service).to receive(:get).and_return('mocked_response')
      end

      it 'calls the HTTP service with the correct URL' do
        fetcher.fetch
        expect(http_service).to have_received(:get).with(fetcher_class::URL)
      end

      it 'parses the response and returns the result' do
        result = fetcher.fetch
        expect(result).to eq('mocked_response')
      end
    end

    context 'when the HTTP service returns nil' do
      before do
        allow(http_service).to receive(:get).and_return(nil)
      end

      it 'returns an empty array' do
        result = fetcher.fetch
        expect(result).to eq([])
      end
    end

    context 'when the subclass does not implement parse' do
      let(:incomplete_fetcher_class) do
        Class.new(described_class) do
          self::URL = 'https://example.com'
        end
      end
      let(:incomplete_fetcher) { incomplete_fetcher_class.new(http_service:) }

      it 'raises a NotImplementedError' do
        allow(http_service).to receive(:get).and_return('mocked_response')
        expect { incomplete_fetcher.fetch }.to raise_error(NotImplementedError, 'Subclasses must implement the `parse` method')
      end
    end
  end
end
