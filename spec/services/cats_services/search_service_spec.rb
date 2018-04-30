require 'rails_helper'

describe CatsServices::SearchService, type: :service do
  let(:service) { described_class }

  let(:search_params) { {location: 'Odessa'} }
  let(:single_cat_in_odessa) { create(:cat, :in_odessa) }

  before { create_list(:cat, 10) }

  describe '.find_by' do
    it 'returns Cats based on passed parameters' do
      result = service.find_by(search_params)
      expect(result).to eq([single_cat_in_odessa])
    end

    it 'delegates querying to Cat model' do
      allow(Cat).to receive(:where).with(search_params)

      service.find_by(search_params)
      expect(Cat).to have_received(:where)
    end
  end
end
