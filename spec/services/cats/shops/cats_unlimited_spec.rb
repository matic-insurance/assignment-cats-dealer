# frozen_string_literal: true

require 'rails_helper'

describe Cats::Shops::CatsUnlimited do
  it 'calls client with correct url' do
    url = 'https://fake.com/api'
    client = double(call: [])

    described_class.new(client: client, url: url).call

    expect(client).to have_received(:call).with(url)
  end

  it 'returns list of records' do
    client = double(call: ::Fixtures::Cats.cats_unlimited)

    result = described_class.new(client: client).call

    expect(result.count).to eq(3)
  end

  it 'builds records correctly' do
    record = {
      'name' => 'Abyssin',
      'price' => 500,
      'location' => 'Lviv',
      'image' => 'https =>//picsum.photos/200'
    }
    client = double(call: [record])

    cat = described_class.new(client: client).call.first

    aggregate_failures('testing record') do
      expect(cat.name).to eq('Abyssin')
      expect(cat.price).to eq(500)
      expect(cat.location).to eq('Lviv')
      expect(cat.image).to eq('https =>//picsum.photos/200')
    end
  end
end
