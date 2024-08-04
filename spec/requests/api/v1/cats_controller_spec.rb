# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CatsController, type: :request do
  let(:base_route) { '/api/v1/cats' }
  let(:response_body) { response.parsed_body }

  describe 'GET /index' do
    let(:params) do
      {
        location: 'Donezk',
        cat_type: 'American Curl'
      }
    end

    context 'when data is available' do
      let(:cats_data) do
        [
          { 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Donezk', 'image' => 'https://olxua-ring07' },
          { 'cat_type' => 'Siberian', 'price' => 300, 'location' => 'Donezk', 'image' => 'https://olxua-ring08' }
        ]
      end

      before { allow_any_instance_of(CatFinderService).to receive(:call).and_return(cats_data) }

      it 'returns the cats data' do
        get base_route, params: params

        expect(response).to have_http_status(:success)
        expect(response_body).to eq(cats_data)
      end
    end

    context 'when no data is available' do
      let(:error_message) { 'No data available from any source' }

      before { allow_any_instance_of(CatFinderService).to receive(:call).and_raise(NoDataAvailableError, error_message) }

      it 'returns an error message' do
        get base_route, params: params

        expect(response).to have_http_status(:service_unavailable)
        expect(response_body).to eq({ 'message' => error_message })
      end
    end
  end
end
