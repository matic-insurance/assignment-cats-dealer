# frozen_string_literal: true

require 'rails_helper'

describe Cats::Shops::HappyCats do
  it 'calls client with correct url' do
    url = 'https://fake.com/api'
    client = double(call: {})

    described_class.new(client: client, url: url).call

    expect(client).to have_received(:call).with(url)
  end

  it 'returns list of records' do
    client = double(call: ::Fixtures::Cats.happy_cats)

    result = described_class.new(client: client).call

    expect(result.count).to eq(3)
  end

  it 'builds records correctly' do
    response = {
      cats: {
        cat: [
          {
            title: 'American Curl',
            cost: '650',
            location: 'Odessa',
            img: 'https://picsum.photos/200'
          }
        ]
      }
    }
    client = double(call: response)

    cat = described_class.new(client: client).call.first

    aggregate_failures('testing record') do
      expect(cat.name).to eq('American Curl')
      expect(cat.price).to eq(650)
      expect(cat.location).to eq('Odessa')
      expect(cat.image).to eq('https://picsum.photos/200')
    end
  end
end
