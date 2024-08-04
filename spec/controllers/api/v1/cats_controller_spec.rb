require 'rails_helper'

describe Api::V1::CatsController, type: :controller do
  describe 'GET #best_deal' do
    it 'returns no content' do
      get :best_deal
      expect(response).to have_http_status(:no_content)
    end
  end
end
