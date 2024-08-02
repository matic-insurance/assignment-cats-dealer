require 'rails_helper'

describe Shops::FindCheaper::FetchAllRecords do
  subject(:interactor) { described_class.new }

  let(:cats_happy_response) { [{shop_name: 'CatsHappy', price: 10, name: 'American Curl'}] }
  let(:cats_unlimited_response) { [{shop_name: 'CatsUnlimited', price: 20, name: 'Bengal'}] }

  before do
    allow(Shops::CatsHappyService).to receive(:call).and_return(cats_happy_response)
    allow(Shops::CatsUnlimitedService).to receive(:call).and_return(cats_unlimited_response)
  end

  describe '#call' do
    it 'fetches records from all shops' do
      interactor.call
      expect(interactor.records).to match_array(cats_happy_response + cats_unlimited_response)
    end

    it 'assigns the fetched records to context.records' do
      expect { interactor.call }.to change { interactor.context.records }
        .from(nil).to(match_array(cats_happy_response + cats_unlimited_response))
    end
  end
end
