require 'rails_helper'

describe CatsController do
  describe 'GET #index' do
    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #search' do
    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
