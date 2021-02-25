require 'rails_helper'

describe BestOffer do
  subject(:best_offer) { described_class.new(name: name, location: location).call }

  let(:name)     { 'Abyssin' }
  let(:location) { 'Lviv' }

  vcr_options = { cassette_name: 'data/all_cats' }

  it 'returns correct best price', vcr: vcr_options do
    expect(best_offer.best_price).to eq 500
  end

  it 'returns correct filtered cats list', vcr: vcr_options do
    expect(best_offer.cats_list).to contain_exactly(
      an_object_having_attributes(name: name, location: location, price: 500),
      an_object_having_attributes(name: name, location: location, price: 550)
    )
  end
end
