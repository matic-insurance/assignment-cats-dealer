# frozen_string_literal: true

require 'rails_helper'

describe Shops::FetchCats do
  describe '.call' do
    let(:result) { described_class.call }
    let(:cat_list) { result.cat_list }

    context 'when without parameters', vcr: 'fetch_all_cats' do
      it 'retrieves list of all cats' do
        expect(cat_list.size).to eq(21)
        expect(cat_list.sample).to be_a(Shops::Cat)
      end

      it 'returns list ordered by price' do
        expect(cat_list.first.price).to eq(20)
        expect(cat_list.last.price).to eq(800)
      end
    end

    context 'when with shops parameter', vcr: 'cats_unlimited' do
      let(:result) { described_class.call(shops: ['cats_unlimited']) }

      it 'retrieves only cats from appropriate shops' do
        expect(cat_list.size).to eq(11)
        expect(cat_list.sample).to be_a(Shops::Cat)
        expect(cat_list.map(&:shop_key)).to eq(Array.new(11, 'cats_unlimited'))
      end

      it 'returns list ordered by price' do
        expect(cat_list.first.price).to eq(20)
        expect(cat_list.last.price).to eq(700)
      end

      # TODO: test with wrong value
    end

    context 'when with location parameter', vcr: 'fetch_all_cats' do
      let(:result) { described_class.call(location: 'Lviv') }

      it 'retrieves only cats with appropriate location' do
        expect(cat_list.size).to eq(5)
        expect(cat_list.sample).to be_a(Shops::Cat)
        expect(cat_list.map(&:location)).to eq(Array.new(5, 'Lviv'))
      end

      it 'returns list ordered by price' do
        expect(cat_list.first.price).to eq(500)
        expect(cat_list.last.price).to eq(650)
      end
    end

    context 'when with cat_type parameter', vcr: 'fetch_all_cats' do
      let(:result) { described_class.call(cat_type: 'Sphynx') }

      it 'retrieves only cats with appropriate type' do
        expect(cat_list.size).to eq(2)
        expect(cat_list.sample).to be_a(Shops::Cat)
        expect(cat_list.map(&:cat_type)).to eq(Array.new(2, 'Sphynx'))
      end

      it 'returns list ordered by price' do
        expect(cat_list.first.price).to eq(230)
        expect(cat_list.last.price).to eq(250)
      end
    end

    context 'when one of the shops cannot be parsed ("cats unlimited")', vcr: 'double_happy_cats' do
      before do
        fake_cats_unlimited_api = Shops::CatsUnlimitedApi.new
        allow(fake_cats_unlimited_api).to receive(:url) { 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml' }
        allow(Shops::CatsUnlimitedApi).to receive(:new) { fake_cats_unlimited_api }
      end

      it 'retrieves only cats from "haapy cats" shop' do
        expect(cat_list.size).to eq(10)
        expect(cat_list.sample).to be_a(Shops::Cat)
        expect(cat_list.map(&:shop_key)).to eq(Array.new(10, 'happy_cats'))
      end

      it 'returns happy_cats in processed_shops' do
        expect(result.processed_shops).to eq(['happy_cats'])
      end

      it 'returns cats_unlimited in failed_shops' do
        expect(result.failed_shops).to eq(['cats_unlimited'])
      end
    end
  end
end
