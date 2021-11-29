# frozen_string_literal: true

require 'rails_helper'

describe Shops::CatList do
  let(:cat1) { Shops::Cat.new(cat_type: 'Bengal', location: 'Lviv', price: 1) }
  let(:cat2) { Shops::Cat.new(cat_type: 'Bengal', location: 'Odessa', price: 2) }
  let(:cat3) { Shops::Cat.new(cat_type: 'Abyssin', location: 'Odessa', price: 3) }

  let(:cat_list) { described_class.new([cat1, cat2, cat3]) }

  describe '#where' do
    let(:result) { cat_list.where(cat_type: 'Bengal', location: 'Odessa') }

    it 'returns filtered cats' do
      expect(result).to eq(described_class.new([cat2]))
    end

    context 'when filter values with lowercase letter' do
      let(:result) { cat_list.where(cat_type: 'bengal', location: 'odessa') }

      it 'works the same: returns filtered cats' do
        expect(result).to eq(described_class.new([cat2]))
      end
    end
  end
end
