require 'rails_helper'

describe CatsDealers::Clients::HappyCats do
  subject(:happy_cats_client) { described_class.new }

  describe '#get' do
    it 'sends GET request' do
      VCR.use_cassette('cat_dealers/happy_cats_full_list') do
        response = happy_cats_client.get
        expect(response).to be_an(Hash)
      end
    end
  end
end
