require 'rails_helper'

describe CatsDealer do
  it 'respond to get_deals method' do
    expect(described_class).to respond_to(:get_deals)
  end
end