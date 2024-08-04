require 'rails_helper'

describe 'Cats API', type: :request do
  describe 'GET /api/v1/cats/best_deal' do
    it 'returns no content' do
      get '/api/v1/cats/best_deal'
      expect(response).to have_http_status(:no_content)
    end
  end
end
