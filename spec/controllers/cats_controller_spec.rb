require 'rails_helper'

describe CatsController do
  describe 'GET #index' do
    let(:response_structure) { double(success?: status, data: [], errors: []) }

    context 'success' do
      let(:status) { true }

      it 'returns status code 200' do
        expect(Cats::ListService).to receive(:call).and_return(response_structure)

        get :index

        expect(response).to have_http_status(:ok)
      end
    end

    context 'redirect' do
      let(:status) { false }

      it 'returns status code 302' do
        expect(Cats::ListService).to receive(:call).and_return(response_structure)

        get :index

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
