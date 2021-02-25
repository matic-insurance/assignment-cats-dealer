require 'rails_helper'

describe AllCats do
  subject(:cats) { described_class.new.call }

  vcr_options = { cassette_name: 'data/all_cats' }

  it 'returns array of Cat objects', vcr: vcr_options do
    expect(cats).to all be_a Cat
  end

  it 'returns correct array size', vcr: vcr_options do
    expect(cats.size).to eq 21
  end

  context 'when the new shop is added without adapter' do
    before { stub_const('AllCats::SHOPS', %w[Cats\ Unlimited Happy\ Cats New\ Shop]) }

    it 'raises error', :vcr do
      expect { cats }.to raise_error described_class::MISSING_ADAPTER_ERROR
    end
  end
end
