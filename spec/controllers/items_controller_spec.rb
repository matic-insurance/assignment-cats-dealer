require 'rails_helper'

describe ItemsController do
  describe 'GET #index' do
    let(:params) { {id: 'some'} }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)

      get 'index'
    end
  end
end
