# frozen_string_literal: true

require 'rails_helper'

describe Shops::FetchCats do
  describe '.call' do
    context 'when without parameters' do
      let(:result) { described_class.call }

      it 'retrieves list of all cats', vcr: 'fetch_all_cats' do
        expect(result.size).to eq(21)
        expect(result.sample).to be_a(Shops::Cat)
      end

      it 'returns list ordered by price' do
        expect(result.first.price).to eq(20)
        expect(result.last.price).to eq(800)
      end
    end

    context 'when with shops parameter' do
      it 'retrieves only cats from appropriate shops', vcr: 'cats_unlimited' do
        result = described_class.call(shops: ['cats_unlimited'])

        expect(result.size).to eq(11)
        expect(result.sample).to be_a(Shops::Cat)
        expect(result.map(&:shop_key)).to eq(Array.new(11, 'cats_unlimited'))
      end

      it 'returns list ordered by price' do
        expect(result.first.price).to eq(20)
        expect(result.last.price).to eq(700)
      end

      # TODO: test with wrong value
    end

    context 'when with location parameter' do
      it 'retrieves only cats with appropriate location', vcr: 'fetch_all_cats' do
        result = described_class.call(location: 'Lviv')

        expect(result.size).to eq(5)
        expect(result.sample).to be_a(Shops::Cat)
        expect(result.map(&:location)).to eq(Array.new(5, 'Lviv'))
      end

      it 'returns list ordered by price' do
        expect(result.first.price).to eq(500)
        expect(result.last.price).to eq(650)
      end
    end

    context 'when with cat_type parameter' do
      it 'retrieves only cats with appropriate type', vcr: 'fetch_all_cats' do
        result = described_class.call(cat_type: 'Sphynx')

        expect(result.size).to eq(2)
        expect(result.sample).to be_a(Shops::Cat)
        expect(result.map(&:cat_type)).to eq(Array.new(2, 'Sphynx'))
      end

      it 'returns list ordered by price' do
        expect(result.first.price).to eq(230)
        expect(result.last.price).to eq(250)
      end
    end
  end
end
