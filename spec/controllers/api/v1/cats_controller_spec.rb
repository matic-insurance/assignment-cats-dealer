# frozen_string_literal: true

require 'rails_helper'

describe 'CatsController' do
  describe '#index', type: :request do
    let(:path) { '/api/v1/cats' }

    context 'without filter parameters' do
      before { get path }

      it 'returns all cats', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['cats'].size).to eq(21)
      end
    end

    context 'with location parameter' do
      let(:location) { 'Lviv' }

      before { get path, params: {location: location} }

      it 'returns cats with appropriate location', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['cats'].size).to eq(
          response_hash['cats'].select { |i| i['location'] == location }.size
        ).and eq(5)
      end
    end

    context 'with cat_type parameter' do
      let(:cat_type) { 'Bengal' }

      before { get path, params: {cat_type: cat_type} }

      it 'returns cats with appropriate cat_type', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['cats'].size).to eq(
          response_hash['cats'].select { |i| i['cat_type'] == cat_type }.size
        ).and eq(3)
      end
    end

    context 'with location & cat_type parameters' do
      let(:cat_type) { 'Abyssin' }
      let(:location) { 'Lviv' }

      before { get path, params: {location: location, cat_type: cat_type} }

      it 'returns cats with appropriate cat_type & location', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash['cats'].size).to eq(2)
      end
    end
  end
end
