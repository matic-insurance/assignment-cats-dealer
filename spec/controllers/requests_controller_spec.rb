require 'rails_helper'

describe RequestsController do
  describe 'GET #new' do
    before { get 'new' }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
