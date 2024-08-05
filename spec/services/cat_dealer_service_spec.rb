require 'rails_helper'

RSpec.describe CatDealerService do
  let(:location) { 'Kharkiv' }
  let(:cat_type) { 'American Curl' }
  let(:json_response) { File.read(Rails.root.join('spec/fixtures/cats_unlimited/response.json')) }
  let(:xml_response) { File.read(Rails.root.join('spec/fixtures/happy_cats/response.xml')) }

  before do
    allow(RestClient).to receive(:get).with('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json').and_return(double(body: json_response))
    allow(RestClient).to receive(:get).with('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml').and_return(double(body: xml_response))
  end

  describe '.find_best_deal' do
    context 'when cats are available that match the criteria' do
      it 'returns the cat with the lowest price' do
        best_deal = CatDealerService.find_best_deal(location, cat_type)
        expect(best_deal.slice(:cat_type, :price, :location, :image)).to eq({
          cat_type: 'American Curl',
          price: 350,
          location: 'Kharkiv',
          image: 'https://olxua-ring07.akamaized'
        }.with_indifferent_access)
      end
    end

    context 'when no cats match the criteria' do
      let(:json_response) { '[]' }
      let(:xml_response) { '<cats></cats>' }

      it 'returns an error message' do
        best_deal = CatDealerService.find_best_deal(location, cat_type)
        expect(best_deal).to eq({ error: 'No cats found' })
      end
    end

    context 'when an error occurs in fetching cats' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(double))
      end

      it 'returns an error message' do
        best_deal = CatDealerService.find_best_deal(location, cat_type)
        expect(best_deal).to eq({ error: 'No cats found' })
      end
    end
  end
end