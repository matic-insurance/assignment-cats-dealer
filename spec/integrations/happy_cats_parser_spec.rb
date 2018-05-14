require 'rails_helper'
require 'integrations/parsers/happy_cats_parser'

describe HappyCatsParser do

  it 'should be able to pass specified format and return array of hashes' do
    body = file_fixture("happy_cats_response.xml").read
    response = double('response', body: body)
    parsed = HappyCatsParser.parse(response)
    expect(parsed).to be_a(Array)
    expect(parsed.size).to be 2
    required_keys = %w(img title cost location)
    required_keys.each do |key|
      parsed.each do |product|
        expect(product.key?(key)).to be_truthy
      end
    end
  end

  it 'should raise' do
    body = 'invalid string'
    response = double('response', body: body)
    expect{HappyCatsParser.parse(response)}.to raise_error NoMethodError
  end
end