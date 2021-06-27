# frozen_string_literal: true

require 'rails_helper'

describe Cats::Fetch do
  subject(:fetching) { Cats::Fetch.call(filters: filters) }

  let(:filters) { {} }

  context 'when all providers responds normally' do
    let(:cats_unlimited_list) do
      [
        {
          cat_type: 'Bengal',
          price: 700,
          location: 'Kyiv',
          image: 'https://olxua-ring10.akamaized.net/images_slandocomua/496811712_5_1000x700_bengalyata-kievskaya-oblast.jpg'
        }
      ].map(&:stringify_keys)
    end
    let(:happy_cats_list) do
      [
        {
          cat_type: 'Abyssin',
          price: 500,
          location: 'Lviv',
          image: 'https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg'
        }
      ].map(&:stringify_keys)
    end

    before do
      allow(::Cats::Providers::CatsUnlimitedService.instance)
        .to receive(:data).and_return(cats_unlimited_list)
      allow(::Cats::Providers::HappyCatsService.instance)
        .to receive(:data).and_return(happy_cats_list)
    end

    it 'succeeds with cats list' do
      expect(fetching.success?).to eq true
      expect(fetching.list).to eq cats_unlimited_list + happy_cats_list
    end

    context 'when filters present' do
      context 'with cat_type' do
        let(:filters) { { 'cat_type' => 'Bengal' } }

        it 'succeeds with filtered cats list' do
          expect(fetching.success?).to eq true
          expect(fetching.list).to contain_exactly(cats_unlimited_list[0])
        end
      end

      context 'with location' do
        let(:filters) { { 'location' => 'Lviv' } }

        it 'succeeds with filtered cats list' do
          expect(fetching.success?).to eq true
          expect(fetching.list).to contain_exactly(happy_cats_list[0])
        end
      end

      context 'with cat_type and location' do
        let(:filters) { { 'cat_type' => 'Abyssin', 'location' => 'Lviv' } }

        it 'succeeds with filtered cats list' do
          expect(fetching.success?).to eq true
          expect(fetching.list).to contain_exactly(happy_cats_list[0])
        end
      end
    end
  end

  context 'when one of providers failure' do
    before do
      allow(::Cats::Providers::CatsUnlimitedService.instance)
        .to receive(:data).and_raise(ProviderUnavailableError, 'Provider stub')
    end

    it 'failure with expected error' do
      expect(fetching.success?).to eq false
      expect(fetching.error)
        .to eq 'Service "Provider stub" is unavailable. Try again later'
    end
  end
end
