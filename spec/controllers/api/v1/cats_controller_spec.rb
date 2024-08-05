require 'rails_helper'

describe Api::V1::CatsController, type: :controller do
  let(:logger) { instance_double("Logger") }

  before do
    allow(Rails).to receive(:logger).and_return(logger)
    allow(logger).to receive(:error)
  end

  describe 'GET #best_deal' do
    let(:location) { 'New York' }
    let(:cat_type) { 'Siamese' }
    let(:best_deal) { { name: 'Fluffy', price: 100 } }
    context 'successful request' do
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
    context 'StandardError raised' do
      before do
        allow(CatDealerService).to receive(:find_best_deal).and_raise(StandardError)
      end

      it 'returns a 500 status code' do
        get :best_deal, params: { user_location: location, cats_type: cat_type }
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns an error message' do
        get :best_deal, params: { user_location: location, cats_type: cat_type }
        expect(response.body).to eq({ error: 'StandardError' }.to_json)
      end

      it 'logs the error' do
        get :best_deal, params: { user_location: location, cats_type: cat_type }
        expect(logger).to have_received(:error).with("StandardError: StandardError")
      end
    end
    context 'ParameterMissing raised' do
      before do
        allow(CatDealerService).to receive(:find_best_deal).and_raise(ActionController::ParameterMissing.new(:user_location))
      end

      it 'returns a 500 status code' do
        get :best_deal, params: { user_location: location, cats_type: cat_type }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns an error message' do
        get :best_deal, params: { user_location: location, cats_type: cat_type }
        expect(response.body).to eq({ error: 'param is missing or the value is empty: user_location' }.to_json)
      end

      it 'logs the error' do
        get :best_deal, params: { user_location: location, cats_type: cat_type }
        expect(logger).to have_received(:error).with("ParameterMissing: param is missing or the value is empty: user_location")
      end
    end
  end
end
