require 'rails_helper'

describe 'CatsController' do
  describe '#index', type: :request do
    let(:path) { '/api/v1/cats' }

    context 'without filter parameters' do
      before { get path }

      it 'returns all cats', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash.size).to eq(11)
      end
    end

    context 'with location parameter' do
      let(:location) { 'Lviv' }

      before { get path, params: { location: location } }

      it 'returns cats with appropriate location', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash.size).to eq(3)
        expect(response_hash.select {|i| i['location'] == location }.size).to eq(3)
      end
    end

    context 'with cat_type parameter' do
      let(:cat_type) { 'Bengal' }

      before { get path, params: { cat_type: cat_type } }

      it 'returns cats with appropriate cat_type', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash.size).to eq(1)
        expect(response_hash.select {|i| i['name'] == cat_type }.size).to eq(1)
      end
    end

    context 'with location & cat_type parameters' do
      let(:cat_type) { 'Abyssin' }
      let(:location) { 'Lviv' }

      before { get path, params: { location: location, cat_type: cat_type } }

      it 'returns cats with appropriate cat_type & location', vcr: 'fetch_all_cats' do
        expect(response).to have_http_status(:success)
        expect(response_hash.size).to eq(2)
        expect(response_hash.select {|i| i['location'] == location && i['name'] == cat_type }.size).to eq(2)
      end
    end
  end
end
