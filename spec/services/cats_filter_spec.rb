require 'rails_helper'

RSpec.describe CatsFilter do
  describe '#call' do
    let(:all_cats) do
      [
        {
          breed: 'Abyssin',
          location: 'Lviv',
          price: 500.0,
        }, {
          breed: 'Abyssin',
          location: 'Odessa',
          price: 550.0,
        }, {
          breed: 'Siamese',
          location: 'Kharkiv',
          price: 200.0,
        }, {
          breed: 'British Shorthair',
          location: 'Kyiv',
          price: 600.0,
        }, {
          breed: 'Bengal',
          location: 'Lviv',
          price: 480.0,
        }, {
          breed: 'American Curl',
          location: 'Vinnytsya',
          price: 800.0,
        }
      ]
    end
    let(:attributes) { {} }

    subject(:cats) { described_class.new.call(all_cats, **attributes) }

    context 'without any attributes' do
      it 'returns original array' do
        expect(cats.size).to eq 6
        expect(cats).to include *all_cats
      end

      it 'sorts cats by price' do
        expect(cats).to eq all_cats.sort_by { _1[:price] }
      end
    end

    context 'with location attribute' do
      shared_examples 'filter by location' do |location, expect_count|
        it 'returns only cats in the location' do
          uniq_locations = cats.pluck(:location).uniq

          expect(cats.size).to eq expect_count
          expect(uniq_locations).to contain_exactly(location)
        end
      end

      let(:attributes) { { location: 'Lviv' } }

      it_behaves_like 'filter by location', 'Lviv', 2

      context 'with different location' do
        let(:attributes) { { location: 'Odessa' } }

        it_behaves_like 'filter by location', 'Odessa', 1
      end

      context 'when location passed in lower case and contains spaces' do
        let(:attributes) { { location: ' odessa ' } }

        it_behaves_like 'filter by location', 'Odessa', 1
      end

      context 'when no cats found by location' do
        let(:attributes) { { location: 'undefined' } }

        it 'returns empty array' do
          expect(cats).to eq []
        end
      end
    end

    context 'with breed attribute' do
      shared_examples 'filter by breed' do |breed, expect_count|
        it 'returns only cats in the location' do
          uniq_breed = cats.pluck(:breed).uniq

          expect(cats.size).to eq expect_count
          expect(uniq_breed).to contain_exactly(breed)
        end
      end
      let(:attributes) { { breed: 'Bengal' } }

      it_behaves_like 'filter by breed', 'Bengal', 1

      context 'with different breed' do
        let(:attributes) { { breed: 'Abyssin' } }

        it_behaves_like 'filter by breed', 'Abyssin', 2
      end

      context 'when location passed in lower case and contains spaces' do
        let(:attributes) { { breed: ' american curl ' } }

        it_behaves_like 'filter by breed', 'American Curl', 1
      end

      context 'when no cats found by location' do
        let(:attributes) { { breed: 'undefined' } }

        it 'returns empty array' do
          expect(cats).to eq []
        end
      end
    end

    context 'with location and breed' do
      let(:attributes) { { breed: 'Bengal', location: 'Lviv' } }

      it 'returns cats by location and breed' do
        expect(cats.size).to eq 1
      end

      it 'returns only cats in the location and breed' do
        uniq_locations = cats.pluck(:location).uniq
        uniq_breed = cats.pluck(:breed).uniq

        expect(uniq_locations).to contain_exactly('Lviv')
        expect(uniq_breed).to contain_exactly('Bengal')
      end

      context 'when no cats found by breed and in the location' do
        let(:attributes) { { breed: 'Abyssin', location: 'Kyiv' } }

        it 'returns empty array' do
          expect(cats).to eq []
        end
      end
    end
  end
end
