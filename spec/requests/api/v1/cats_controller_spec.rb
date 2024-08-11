# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CatsController, type: :request do
  let(:cat_bengal) { Types::Cat.new('Bengal', 500, 'Odessa', 'bengal.jpg') }
  let(:cat_siamese) { Types::Cat.new('Siamese', 300, 'Kyiv', 'siamese.jpg') }
  let(:cat_persian) { Types::Cat.new('Persian', 200, 'Lviv', 'persian.jpg') }
  let(:service) { instance_double(CatService) }

  before do
    allow(CatService).to receive(:new).and_return(service)
  end

  describe 'GET /api/v1/cats' do
    context 'when cats are available' do
      before do
        allow(service).to receive(:fetch_all_cats).and_return([cat_bengal, cat_siamese, cat_persian])
        get '/api/v1/cats'
      end

      it 'returns a 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all cats in the response' do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(3)
        expect(json_response).to include(
                                   hash_including('name' => 'Bengal', 'price' => 500, 'location' => 'Odessa'),
                                   hash_including('name' => 'Siamese', 'price' => 300, 'location' => 'Kyiv'),
                                   hash_including('name' => 'Persian', 'price' => 200, 'location' => 'Lviv')
                                 )
      end
    end

    context 'when no cats are available' do
      before do
        allow(service).to receive(:fetch_all_cats).and_return([])
        get '/api/v1/cats'
      end

      it 'returns a 404 status' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({ 'error' => 'No cats available' })
      end
    end
  end

  describe 'GET /api/v1/cats/best_deal' do
    context 'when a best deal is available' do
      before do
        allow(service).to receive(:find_best_deal).and_return(cat_persian)
        get '/api/v1/cats/best_deal'
      end

      it 'returns a 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the cat with the best deal' do
        json_response = JSON.parse(response.body)
        expect(json_response).to include(
                                   'name' => 'Persian',
                                   'price' => 200,
                                   'location' => 'Lviv',
                                   'image' => 'persian.jpg'
                                 )
      end
    end

    context 'when no best deal is available' do
      before do
        allow(service).to receive(:find_best_deal).and_return(nil)
        get '/api/v1/cats/best_deal'
      end

      it 'returns a 404 status' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({ 'error' => 'No cats available' })
      end
    end
  end
end
