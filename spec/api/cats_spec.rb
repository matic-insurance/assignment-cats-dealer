require 'rails_helper'

describe 'API Cats' do
  describe 'POST /cats' do
    let(:endpoint) { '/cats' }

    let(:cats_type) { nil }
    let(:user_location) { nil }

    let(:expected_cat) do
      {
        name: 'Abyssin',
        price: 500,
        location: 'Lviv',
        image: 'https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg'
      }.stringify_keys
    end

    before do
      VCR.use_cassette('/cats_unlimited/all') do
        get endpoint,
            params: { cats_type: cats_type, user_location: user_location }
      end
    end

    context 'when no filters' do
      it 'responds with whole cats list' do
        expect(response.response_code).to eq 200

        cats = ::Oj.load(response.body)
        expect(cats.size).to eq 11
        expect(cats[0]).to eq expected_cat
      end
    end

    xcontext 'when filters present' do
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
end
