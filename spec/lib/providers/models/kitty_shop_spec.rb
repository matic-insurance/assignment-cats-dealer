require 'rails_helper'
require 'providers/models/kitty_shop'

describe Providers::Models::KittyShop do
  subject(:kitty_shop_class) { described_class }

  let(:parsed_api_response) do
    {
      title: 'American',
      cost: '650',
      location: 'Odessa',
      img: 'https://dummy.com/image.png'
    }.with_indifferent_access
  end

  describe '#new' do
    let(:cat) { kitty_shop_class.new(parsed_api_response) }

    it 'initializes Cat based on the KittyShop specific input hash' do
      allow(parsed_api_response).to receive(:fetch)

      kitty_shop_class.new(parsed_api_response)
      expect(parsed_api_response).to have_received(:fetch).exactly(4).times
    end

    it 'sets cat\'s breed' do
      expected_breed = parsed_api_response['title']
      expect(cat.breed).to eq(expected_breed)
    end

    it 'sets cat\'s price' do
      expected_price = parsed_api_response['cost']
      expect(cat.price).to eq(expected_price)
    end

    it 'sets cat\'s location' do
      expected_location = parsed_api_response['location']
      expect(cat.location).to eq(expected_location)
    end

    it 'sets cat\'s picture' do
      expected_picture = parsed_api_response['img']
      expect(cat.picture_url).to eq(expected_picture)
    end
  end
end
