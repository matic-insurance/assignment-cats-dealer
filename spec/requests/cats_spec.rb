require 'rails_helper'

RSpec.describe 'Cats', cassette_names: %w(all_cats_unlimited all_happy_cats) do
  describe 'GET /cats' do
    let(:params) { {} }
    subject { get '/cats', params: params }

    it 'returns all cats' do
      subject

      body = JSON.parse(response.body)

      expect(body.size).to eq 21
      expect(response.body).to include_json(
        [{
          breed: 'Siamese',
          price: 20,
          location: 'Kharkiv',
          image: a_string_starting_with('https')
        }]
      )
    end

    context 'with location param' do
      shared_examples 'filter by location' do |location, expect_count|
        it 'returns cats by location' do
          subject

          body = JSON.parse(response.body)

          expect(body.size).to eq expect_count
        end

        it 'returns only cats in the location' do
          subject

          body = JSON.parse(response.body)
          uniq_locations = body.map { _1['location'] }.uniq

          expect(uniq_locations).to contain_exactly(location)
        end
      end

      let(:params) { { location: 'Lviv' } }

      it_behaves_like 'filter by location', 'Lviv', 5

      context 'with different location' do
        let(:params) { { location: 'Odessa' } }

        it_behaves_like 'filter by location', 'Odessa', 6
      end

      context 'when location passed in lower case and contains spaces' do
        let(:params) { { location: ' odessa ' } }

        it_behaves_like 'filter by location', 'Odessa', 6
      end

      context 'when no cats found by location' do
        let(:params) { { location: 'undefined' } }

        it 'returns empty array' do
          subject

          expect(response.body).to eq '[]'
        end
      end
    end

    context 'with breed param' do
      shared_examples 'filter by breed' do |breed, expect_count|
        it 'returns cats by location' do
          subject

          body = JSON.parse(response.body)

          expect(body.size).to eq expect_count
        end

        it 'returns only cats in the location' do
          subject

          body = JSON.parse(response.body)
          uniq_breed = body.map { _1['breed'] }.uniq

          expect(uniq_breed).to contain_exactly(breed)
        end
      end
      let(:params) { { breed: 'Bengal' } }

      it_behaves_like 'filter by breed', 'Bengal', 3

      context 'with different breed' do
        let(:params) { { breed: 'Abyssin' } }

        it_behaves_like 'filter by breed', 'Abyssin', 2
      end

      context 'when location passed in lower case and contains spaces' do
        let(:params) { { breed: ' sphynx ' } }

        it_behaves_like 'filter by breed', 'Sphynx', 2
      end

      context 'when no cats found by location' do
        let(:params) { { breed: 'undefined' } }

        it 'returns empty array' do
          subject

          expect(response.body).to eq '[]'
        end
      end
    end

    context 'with location and breed' do
      let(:params) { { breed: 'Bengal', location: 'Kyiv' } }

      it 'returns cats by location and breed' do
        subject

        body = JSON.parse(response.body)

        expect(body.size).to eq 2
      end

      it 'returns only cats in the location and breed' do
        subject

        body = JSON.parse(response.body)
        uniq_locations = body.map { _1['location'] }.uniq
        uniq_breed = body.map { _1['breed'] }.uniq

        expect(uniq_locations).to contain_exactly('Kyiv')
        expect(uniq_breed).to contain_exactly('Bengal')
      end

      context 'when no cats found by breed and in the location' do
        let(:params) { { breed: 'Abyssin', location: 'Kyiv' } }

        it 'returns empty array' do
          subject

          expect(response.body).to eq '[]'
        end
      end
    end
  end
end
