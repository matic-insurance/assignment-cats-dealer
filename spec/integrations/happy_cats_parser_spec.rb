require 'rails_helper'
require 'integrations/parsers/happy_cats_parser'

describe HappyCatsParser do
  it 'is able to pass specified format and return array of hashes' do
    body = file_fixture('happy_cats_response.xml').read
    response = double('response', body: body)
    parsed = described_class.parse(response)
    expect(parsed).to be_a(Array)
    expect(parsed.size).to be 2
    required_keys = %w[img title cost location]
    required_keys.each do |key|
      parsed.each do |product|
        expect(product).to be_key(key)
      end
    end
  end

  it 'raises' do
    body = 'invalid string'
    response = double('response', body: body)
    expect { described_class.parse(response) }.to raise_error NoMethodError
  end
end
