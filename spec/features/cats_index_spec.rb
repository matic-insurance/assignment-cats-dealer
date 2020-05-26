require 'rails_helper'

RSpec.describe 'index page returns items sorted by price', type: :feature do
  it 'user enters index page, gets the table' do
    # lowest price active
    Fabricate(:item, price: 2)
    # lowest price in arhcove
    Fabricate(:item, price: 1, active: false)
    # 5 more with 5 digits prices
    5.times { Fabricate(:item) }

    visit '/'

    expect(find('table.items tr:first-child td:nth-child(2)').text).to eq('2.00 ₴')
  end

  describe 'got 3 different cities and breeeds' do
    let(:breed) { Item.first.breed.name }
    let(:city) { Item.first.city.name }

    before do
      3.times { Fabricate(:item) }
    end

    context 'when filter by breed' do
      it 'returns single item with selected breed' do
        visit '/'

        page.select breed, from: 'breed'

        find('#filters_submit').click

        expect(find('.item td:nth-child(1)').text).to eq(breed)
      end
    end

    context 'when filter by city' do
      it 'returns single item with selected city' do
        visit '/'

        page.select city, from: 'city'

        find('#filters_submit').click

        expect(find('.item td:nth-child(3)').text).to eq(city)
      end
    end
  end
end
