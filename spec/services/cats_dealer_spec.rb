require 'rails_helper'

describe CatsDealer do
  it 'respond to search method' do
    expect(described_class).to respond_to(:search)
  end
end
