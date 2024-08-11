# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fetchers::HappyCatsFetcher do
  let(:fetcher) { described_class.new }
  let(:http_service) { instance_double(HttpService) }
  let(:response_body) do
    <<-XML
      <cats>
        <cat>
          <title>Bengal</title>
          <cost>600</cost>
          <location>Odesa</location>
          <img>bengal.jpg</img>
        </cat>
        <cat>
          <title>Siamese</title>
          <cost>400</cost>
          <location>Kyiv</location>
          <img>siamese.jpg</img>
        </cat>
      </cats>
    XML
  end

  before do
    allow(fetcher).to receive(:http_service).and_return(http_service)
    allow(http_service).to receive(:get).with(described_class::URL).and_return(response_body)
    allow(Rails.logger).to receive(:error)
  end

  describe '#fetch' do
    it 'fetches and parses the XML response, returning an array of Cat objects' do
      cats = fetcher.fetch

      expect(cats.size).to eq(2)
      expect(cats.first).to be_an_instance_of(Types::Cat)
      expect(cats.first).to have_attributes(
                              name: 'Bengal',
                              price: 600.0,
                              location: 'Odesa',
                              image: 'bengal.jpg'
                            )
      expect(cats.last).to be_an_instance_of(Types::Cat)
      expect(cats.last).to have_attributes(
                             name: 'Siamese',
                             price: 400.0,
                             location: 'Kyiv',
                             image: 'siamese.jpg'
                           )
    end

    it 'returns an empty array if the response contains no cats' do
      allow(http_service).to receive(:get).with(described_class::URL).and_return('<cats></cats>')

      cats = fetcher.fetch

      expect(cats).to eq([])
    end

    context 'when the response contains invalid cat data' do
      let(:response_body) do
        <<-XML
          <cats>
            <cat>
              <title>Bengal</title>
              <cost>600</cost>
              <location>Odesa</location>
              <img>bengal.jpg</img>
            </cat>
            <cat>
              <title>Siamese</title>
              <cost>400</cost>
              <img>siamese.jpg</img>
            </cat>
          </cats>
        XML
      end

      it 'logs an error and skips the invalid cat' do
        cats = fetcher.fetch

        expect(cats.size).to eq(1)
        expect(cats.first).to have_attributes(
                                name: 'Bengal',
                                price: 600.0,
                                location: 'Odesa',
                                image: 'bengal.jpg'
                              )
        expect(Rails.logger).to have_received(:error).once.with(/Invalid cat data: Location is missing. Skipping this cat./)
      end
    end
  end
end
