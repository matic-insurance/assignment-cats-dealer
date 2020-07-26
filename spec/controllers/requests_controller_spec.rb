require 'rails_helper'

describe RequestsController do
  describe 'GET #new' do
    let(:response_structure) do
      double(
        success?: true,
        data: {
          errors: {},
          locations: [],
          cat_types: []
        }
      )
    end

    it 'returns status code 200' do
      expect(Requests::CreateService).to receive(:call).and_return(response_structure)

      get :new

      expect(response).to have_http_status(:ok)
    end
  end
end
