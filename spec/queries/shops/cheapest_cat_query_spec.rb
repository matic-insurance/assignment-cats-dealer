require 'rails_helper'

describe Shops::CheapestCatQuery do
  subject(:query) { described_class.new(query_params, initial_scope).call }

  let(:initial_scope) do
    [
      {name: 'Bengal', location: 'Kyiv', price: 650},
      {name: 'Bengal', location: 'Odessa', price: 800},
      {name: 'Bobtail', location: 'Odessa', price: 555},
      {name: 'Devon Rex', location: 'Kyiv', price: 209}
    ]
  end

  describe '#call' do
    context 'when filtering only by location' do
      let(:query_params) { {location: 'Odessa'} }
      let(:expected_result) do
        [
          {name: 'Bengal', location: 'Odessa', price: 800},
          {name: 'Bobtail', location: 'Odessa', price: 555}
        ]
      end

      it 'returns the cheapest cat matching the filters' do
        expect(query).to eq(expected_result)
      end
    end

    context 'when filtering only by name' do
      let(:query_params) { {name: 'Devon Rex'} }

      it 'returns the cat matching the name' do
        expect(query).to eq([{name: 'Devon Rex', location: 'Kyiv', price: 209}])
      end
    end

    context 'when no filters are provided' do
      let(:query_params) { {} }

      it 'returns the entire scope' do
        expect(query).to eq(initial_scope)
      end
    end
  end

  describe '#find_cheapest' do
    let(:filtered_scope) do
      [
        {name: 'Bengal', location: 'Odessa', price: 650},
        {name: 'Bengal', location: 'Odessa', price: 800}
      ]
    end
    let(:expected_result) { {name: 'Bengal', location: 'Odessa', price: 650} }

    it 'returns the record with the lowest price' do
      query_params = {location: 'Odessa', name: 'Bengal'}
      query_instance = described_class.new(query_params, filtered_scope)
      expect(query_instance.send(:find_cheapest, filtered_scope)).to eq(expected_result)
    end
  end
end
