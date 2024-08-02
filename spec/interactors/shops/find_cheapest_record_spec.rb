require 'rails_helper'

describe Shops::FindCheaper::FindCheapestRecord do
  subject(:interactor) { described_class.call(context) }

  let(:query_params) { {location: 'Odessa', name: 'Bengal'} }
  let(:cheapest_cat_query) { instance_double(Shops::CheapestCatQuery) }
  let(:records) do
    [
      {name: 'Bengal', price: 15, location: 'Odessa'},
      {name: 'Bengal', price: 10, location: 'Odessa'},
      {name: 'Bengal', price: 5, location: 'Lviv'}
    ]
  end
  let(:cheapest_record) { {name: 'Bengal', price: 10, location: 'Odessa'} }
  let(:context) { Interactor::Context.new(query_params:, records:) }

  before do
    allow(Shops::CheapestCatQuery).to receive(:new).with(query_params,
                                                         records).and_return(cheapest_cat_query)
    allow(cheapest_cat_query).to receive(:call).and_return(cheapest_record)
  end

  describe '#call' do
    it 'finds the cheapest record' do
      interactor
      expect(interactor.record).to eq(cheapest_record)
    end

    it 'assigns the cheapest record to context.record' do
      expect { interactor }.to change(context, :record).from(nil).to(cheapest_record)
    end

    it 'initializes Shops::CheapestCatQuery with correct arguments' do
      interactor
      expect(Shops::CheapestCatQuery).to have_received(:new).with(query_params, records)
    end

    it 'calls the .call method on Shops::CheapestCatQuery' do
      interactor
      expect(cheapest_cat_query).to have_received(:call)
    end
  end
end
