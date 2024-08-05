require 'rails_helper'

describe 'Api::V1::Cats', type: :request do
  describe 'GET /api/v1/cats/best_deal' do
    let(:location) { 'New York' }
    let(:cat_type) { 'Siamese' }
    let(:best_deal) { { name: 'Fluffy', price: 100 } }

    before do
      allow(CatDealerService).to receive(:find_best_deal).and_return(best_deal)
    end

    context 'successful request' do
      it 'returns a successful response' do
        get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct JSON response' do
        get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
        expect(response.body).to eq(best_deal.to_json)
      end
    end

    context 'when StandardError is raised' do
      before do
        allow(CatDealerService).to receive(:find_best_deal).and_raise(StandardError)
      end

      it 'returns a 500 status code' do
        get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns an error message' do
        get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
        expect(response.body).to eq({ error: 'StandardError' }.to_json)
      end
    end

    context 'when ParameterMissing is raised' do
      before do
        allow(CatDealerService).to receive(:find_best_deal).and_raise(ActionController::ParameterMissing.new(:user_location))
      end

      it 'returns a 400 status code' do
        get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns an error message' do
        get '/api/v1/cats/best_deal', params: { user_location: location, cats_type: cat_type }
        expect(response.body).to eq({ error: 'param is missing or the value is empty: user_location' }.to_json)
      end
    end
  end
end
