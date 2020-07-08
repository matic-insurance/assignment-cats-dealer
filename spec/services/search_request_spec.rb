require 'rails_helper'

describe SearchRequest do
  subject(:search_request) { described_class.new(cat_type: 'Abyssin', location: 'Lviv') }

  it { is_expected.to have_attributes(cat_type: 'Abyssin', location: 'Lviv') }

  it 'respond to search method' do
    expect(described_class).to respond_to(:search)
  end
end
