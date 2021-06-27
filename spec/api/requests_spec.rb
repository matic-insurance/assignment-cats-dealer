require 'rails_helper'

describe 'API Request' do
  describe 'POST /request' do
    let(:endpoint) { '/request' }

    let(:cats_type) { nil }
    let(:user_location) { nil }

    let(:expected_cat) do
      {
        name: 'Abyssin',
        price: '500',
        location: 'Lviv',
        image: 'https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg'
      }.stringify_keys
    end

    before do
      VCR.use_cassette('/cats_unlimited/all') do
        post endpoint,
             params: { cats_type: cats_type, user_location: user_location }
      end
    end

    context 'when no filters' do
      it 'responds with whole cats list' do
        expect(response.redirect?).to eq true
        redirected_uri = URI.parse(response.location)
        redirected_params = Rack::Utils.parse_nested_query(redirected_uri.query)

        expect(redirected_params['cats_list'].size).to eq 11
        expect(redirected_params['cats_list'][0]).to eq expected_cat
        expect(redirected_params['cat_type']).to eq nil
        expect(redirected_params['location']).to eq nil
      end
    end

    context 'when filters present' do
      let(:cats_type) { 'Bengal' }
      let(:user_location) { 'Kyiv' }

      it 'responds with whole cats list and filters' do
        expect(response.redirect?).to eq true
        redirected_uri = URI.parse(response.location)
        redirected_params = Rack::Utils.parse_nested_query(redirected_uri.query)

        expect(redirected_params['cats_list'].size).to eq 11
        expect(redirected_params['cats_list'][0]).to eq expected_cat
        expect(redirected_params['cat_type']).to eq 'Bengal'
        expect(redirected_params['location']).to eq 'Kyiv'
      end
    end
  end
end
