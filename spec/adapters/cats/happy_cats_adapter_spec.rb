require 'rails_helper'

RSpec.describe Cats::HappyCatsAdapter do
  describe '.fetch_items' do
    it 'calls Faraday' do
      stub_faraday

      described_class.fetch_items

      expect(Faraday).
        to have_received(:get).
        with(described_class::API_URL)
    end

    it 'parses response' do
      api_response = {
        cat: [
          {
            title: 'Grumpy',
            cost: '123',
            location: 'Kyiv',
            img: 'link.to/image.jpg'
          },
        ]
      }.to_xml(root: 'cats')

      expected_result = [
        {
          breed: 'Grumpy',
          price: 123,
          location: 'Kyiv',
          image: 'link.to/image.jpg'
        }
      ]

      stub_faraday(body: api_response)

      result = described_class.fetch_items

      expect(result).to eq(expected_result)
    end

    context 'if server responds with empty root element' do
      it 'returns empty array' do
        empty_body = [].to_xml(root: 'cats')
        stub_faraday(body: empty_body, status: 200)

        result = described_class.fetch_items

        expect(result).to eq([])
      end
    end

    context 'if server returns 404' do
      it 'returns empty array' do
        stub_faraday(body: 'Not found', status: 404)

        result = described_class.fetch_items

        expect(result).to eq([])
      end
    end

    context 'if servers returns status 5xx' do
      it 'raises Cats::HappyCatsAdapter::ServerError' do

        stub_faraday(body: 'Something went wrong', status: 500)

        expect { described_class.fetch_items }.to raise_error(Cats::HappyCatsAdapter::ServerError)
      end
    end
  end

  def stub_faraday(body: [].to_xml(root: 'cats'), status: 200)
    faraday_response = instance_double(
      'Faraday::Response',
      status: status,
      body: body,
    )

    allow(Faraday).
      to receive(:get).
      with(described_class::API_URL).
      and_return(faraday_response)
  end
end
