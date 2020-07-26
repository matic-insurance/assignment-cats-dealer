require 'rails_helper'

describe Cats::ManagerService do
  context 'valid params' do
    let(:valid_params) { { cars_type: Faker::String.random(length: 4) } }
    let(:store_result) { [Faker::String.random(length: 4)] }
    let(:filter_result) { [Faker::String.random(length: 4)] }

    it 'calls needed services' do
      expect(Store::ExecutorService).to receive(:call).and_return(store_result)
      expect(Cats::FilterService)
        .to receive(:call).with(valid_params.merge(cats_list: store_result)).and_return(filter_result)

      result = described_class.(valid_params)

      expect(result).to eq(filter_result)
    end
  end
end
