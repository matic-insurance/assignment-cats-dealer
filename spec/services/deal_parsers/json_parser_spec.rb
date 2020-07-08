require 'rails_helper'

describe DealParsers::JsonParser do
  it { expect(described_class).to respond_to(:parse) }
end