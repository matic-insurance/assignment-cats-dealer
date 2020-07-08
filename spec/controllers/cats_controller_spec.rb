require 'rails_helper'

describe CatsController do
  describe 'GET #index' do
    before { get 'new' }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
