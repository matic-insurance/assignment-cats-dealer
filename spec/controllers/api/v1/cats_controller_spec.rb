require 'rails_helper'

describe Api::V1::CatsController, type: :controller do
  describe 'GET #best_deal' do
    let(:location) { 'New York' }
    let(:cat_type) { 'Siamese' }
    let(:best_deal) { { name: 'Fluffy', price: 100 } }

    before do
      allow(CatDealerService).to receive(:find_best_deal).and_return(best_deal)
    end

    it 'returns a successful response' do
      get :best_deal, params: { user_location: location, cats_type: cat_type }
      expect(response).to have_http_status(:ok)
    end

    it 'calls CatDealerService.find_best_deal with correct parameters' do
      get :best_deal, params: { user_location: location, cats_type: cat_type }
      expect(CatDealerService).to have_received(:find_best_deal).with(location, cat_type)
    end

    it 'returns the correct JSON response' do
      get :best_deal, params: { user_location: location, cats_type: cat_type }
      expect(response.body).to eq(best_deal.to_json)
    end
  end
end
