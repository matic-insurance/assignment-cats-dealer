require 'rails_helper'

describe DealParsers::XmlParser do
  it { expect(described_class).to respond_to(:parse) }
end