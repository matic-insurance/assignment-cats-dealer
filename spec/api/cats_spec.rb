# frozen_string_literal: true

require 'rails_helper'

describe 'API Cats' do
  describe 'GET /cats' do
    let(:endpoint) { '/cats' }

    let(:cat_type) { nil }
    let(:location) { nil }

    let(:expected_unlimited_cat) do
      {
        cat_type: 'Bengal',
        price: 700,
        location: 'Kyiv',
        image: 'https://olxua-ring10.akamaized.net/images_slandocomua/496811712_5_1000x700_bengalyata-kievskaya-oblast.jpg'
      }.stringify_keys
    end
    let(:expected_happy_cat) do
      {
        cat_type: 'Bengal',
        price: 600,
        location: 'Kyiv',
        image: 'https://olxua-ring10.akamaized.net/images_slandocomua/496811712_5_1000x700_bengalyata-kievskaya-oblast.jpg'
      }.stringify_keys
    end

    context 'when success' do
      before do
        VCR.use_cassette('/cats_unlimited/all') do
          VCR.use_cassette('/happy_cats/all') do
            get endpoint,
                params: { cat_type: cat_type, location: location }
          end
        end
      end

      context 'without filters' do
        it 'responds with whole cats list' do
          expect(response.response_code).to eq 200

          cats = json(response.body)
          expect(cats.size).to eq 21
          expect(cats).to include expected_unlimited_cat
        end
      end

      context 'with filters' do
        let(:cat_type) { 'Bengal' }
        let(:location) { 'Kyiv' }

        it 'responds with cats list that matched' do
          expect(response.response_code).to eq 200

          cats = json(response.body)
          expect(cats.size).to eq 2
          expect(cats)
            .to contain_exactly(expected_unlimited_cat, expected_happy_cat)
        end
      end
    end

    context 'when fetching from provider failed' do
      let(:expected_error) { 'Service "Cats Unlimited" is unavailable. Try again later' }

      before do
        VCR.use_cassette('/cats_unlimited/failed') do
          get endpoint,
              params: { cat_type: cat_type, location: location }
        end
      end

      it 'responds with expected 503 message' do
        expect(response.response_code).to eq 503
        expect(json(response.body)['error']).to eq expected_error
      end
    end
  end
end
