# frozen_string_literal: true

require 'rails_helper'

describe Cats::Clients::Xml do
  it 'call http client with correct params' do
    allow(RestClient).to receive(:get)

    described_class.new.call('http://example.com/api')

    expect(RestClient).to have_received(:get).with('http://example.com/api')
  end

  it 'returns parsed response' do
    allow(RestClient).to receive(:get).and_return(Fixtures::Cats.happy_cats_xml)

    result = described_class.new.call('http://example.com/api').dig(:cats, :cat)

    expect(result.count).to eq(3)
  end

  it 'returns empty array when raise an error' do
    allow(RestClient).to receive(:get).and_raise

    result = described_class.new.call('http://example.com/api')

    expect(result.count).to eq(0)
  end
end
