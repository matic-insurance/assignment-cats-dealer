require 'rails_helper'

RSpec.describe 'Api::V1::Cats', type: :request do
  describe 'GET /api/v1/cats/best_deal' do
    let(:location) { 'New York' }
    let(:cat_type) { 'Siamese' }
    let(:best_deal) { { name: 'Fluffy', price: 100 } }

    before do
      allow(CatDealerService).to receive(:find_best_deal).and_return(best_deal)
    end

    it 'returns a successful response' do
      get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct JSON response' do
      get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
      expect(response.body).to eq(best_deal.to_json)
    end
  end
end
