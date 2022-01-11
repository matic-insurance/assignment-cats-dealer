require 'rails_helper'

describe CatsDealers::Clients::CatsUnlimited do
  subject(:cats_unlimited_client) { described_class.new }

  describe '#get' do
    it 'sends GET request' do
      VCR.use_cassette('cat_dealers/cats_unlimited_full_list') do
        response = cats_unlimited_client.get
        expect(response).to be_an(Array)
      end
    end
  end
end
