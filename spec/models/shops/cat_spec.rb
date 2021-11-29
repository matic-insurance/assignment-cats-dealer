# frozen_string_literal: true

require 'rails_helper'

describe Shops::Cat do
  let(:attributes) do
    {
      cat_type: 'Bengal',
      location: 'Lviv',
      price: 200,
      image_url: nil,
      shop_key: 'cute_kittens'
    }
  end

  describe '.new' do
    context 'when with all acceptable attributes' do
      let(:cat) { described_class.new(attributes) }

      it 'initializes new instance with cat_type' do
        expect(cat.cat_type).to eq(attributes[:cat_type])
      end

      it 'initializes new instance with location' do
        expect(cat.location).to eq(attributes[:location])
      end

      it 'initializes new instance with price' do
        expect(cat.price).to eq(attributes[:price])
      end

      it 'initializes new instance with image_url' do
        expect(cat.image_url).to eq(attributes[:image_url])
      end

      it 'initializes new instance with shop_key' do
        expect(cat.shop_key).to eq(attributes[:shop_key])
      end
    end

    context 'when with not acceptable attribute' do
      it 'ignores attributes which are not listed in Shops::Cat::ATTRIBUTES' do
        cat = described_class.new(cat_type: 'Bengal', age: 10)

        expect(cat.cat_type).to eq('Bengal')
        expect { cat.age }.to raise_error(NoMethodError)
      end
    end
  end

  describe '#to_h' do
    it 'returns attributes in hash' do
      cat = described_class.new(attributes)

      expect(cat.to_h).to eq(attributes)
    end
  end
end
