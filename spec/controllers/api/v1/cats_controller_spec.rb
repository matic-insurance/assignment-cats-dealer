# frozen_string_literal: true

require 'rails_helper'

describe 'CatsController' do
  describe '#index', type: :request do
    let(:path) { '/api/v1/cats' }

    context 'without filter parameters' do
      before { get path }

      it 'returns all cats', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['data']['cats'].size).to eq(21)
      end

      it 'returns meta data about shops', vcr: 'fetch_all_cats' do
        expect(response_hash['shops']['processed'].size).to eq(2)
        expect(response_hash['shops']['failed'].size).to eq(0)
      end
    end

    context 'with location parameter' do
      let(:location) { 'Lviv' }

      before { get path, params: {location: location} }

      it 'returns cats with appropriate location', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['data']['cats'].size).to eq(
          response_hash['data']['cats'].select { |i| i['location'] == location }.size
        ).and eq(5)
      end
    end

    context 'with cat_type parameter' do
      let(:cat_type) { 'Bengal' }

      before { get path, params: {cat_type: cat_type} }

      it 'returns cats with appropriate cat_type', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['data']['cats'].size).to eq(
          response_hash['data']['cats'].select { |i| i['cat_type'] == cat_type }.size
        ).and eq(3)
      end
    end

    context 'with location & cat_type parameters' do
      let(:cat_type) { 'Abyssin' }
      let(:location) { 'Lviv' }

      before { get path, params: {location: location, cat_type: cat_type} }

      it 'returns cats with appropriate cat_type & location', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['data']['cats'].size).to eq(2)
      end
    end

    context 'with order_by parameter', vcr: 'fetch_all_cats' do
      context 'with valid parameter value' do
        before { get path, params: {order_by: 'cat_type'} }

        it 'returns cats ordered by parameter value' do
          expect(response).to have_http_status(:success)
          expect(response_hash['data']['cats'].size).to eq(21)
          expect(response_hash['data']['cats'].last['cat_type']).to eq('Sphynx')
        end
      end

      context 'with invalid parameter value' do
        before { get path, params: {order_by: 'name'} }

        it 'returns error' do
          expect(response).to have_http_status(:bad_request)
          expect(response_hash['error']).to eq('order_by has invalid value')
        end
      end
    end
  end
end
