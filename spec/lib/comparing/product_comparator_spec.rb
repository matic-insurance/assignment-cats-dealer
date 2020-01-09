require 'rspec'
require 'rails_helper'
require_relative '../../../app/lib/comparing/product_comparator'
require_relative '../../product_helper'

describe Comparing::ProductComparator do
  items = [
    {name: 'Abyssin', price: 600, location: 'Lviv'},
    {name: 'Abyssin', price: 550, location: 'Lviv'},
    {name: 'Abyssin', price: 400, location: 'Kyiv'}
  ]
  context 'when processing items with non-empty result and valid params' do
    before do
      described_class.new(items, 'Cat', nil, location: 'Lviv').call
    end

    it 'check if filter works' do
      expect(Cat.all.count).to eq(2)
    end

    it 'check if sort works' do
      expect(Cat.first.price).to eq(550)
    end
  end

  context 'when processing items with empty result and valid params' do
    before do
      described_class.new(items, 'Cat', nil, location: 'Ternopil').call
    end

    it 'check if result is empty' do
      expect(Cat.all.count).to eq(0)
    end
  end

  context 'when processing items with non-empty result and invalid params' do
    it 'check if exception raised' do
      expect { described_class.new(items, 'Dog', nil, location: 'Lviv').call }
        .to raise_exception(RuntimeError)
    end
  end
end
