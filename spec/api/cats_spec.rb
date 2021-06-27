require 'rails_helper'

describe 'API Cats' do
  describe 'GET /cats' do
    let(:endpoint) { '/cats' }

    let(:cats_type) { nil }
    let(:user_location) { nil }

    let(:expected_cat) do
      {
        cat_type: 'Abyssin',
        price: 500,
        location: 'Lviv',
        image: 'https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg'
      }.stringify_keys
    end

    context 'when success' do
      before do
        VCR.use_cassette('/cats_unlimited/all') do
          get endpoint,
              params: { cats_type: cats_type, user_location: user_location }
        end
      end

      context 'and no filters' do
        it 'responds with whole cats list' do
          expect(response.response_code).to eq 200

          cats = ::Oj.load(response.body)
          expect(cats.size).to eq 11
          expect(cats[0]).to eq expected_cat
        end
      end

      xcontext 'and filters present' do
        let(:cats_type) { 'Bengal' }
        let(:user_location) { 'Kyiv' }

        it 'responds with whole cats list and filters' do
          expect(response.response_code).to eq 200

          cats = ::Oj.load(response.body)
          expect(cats.size).to eq 11
          expect(cats[0]).to eq expected_cat
        end
      end
    end

    context 'when fetching from provider failed' do
      let(:expected_error) { 'Service "Cats Unlimited" is unavailable. Try again later' }

      before do
        VCR.use_cassette('/cats_unlimited/failed') do
          get endpoint,
              params: { cats_type: cats_type, user_location: user_location }
        end
      end

      it 'responds with expected 503 message' do
        expect(response.response_code).to eq 503
        expect(::Oj.load(response.body)['error']).to eq expected_error
      end
    end
  end
end
