require 'rails_helper'

describe Cats::ListService do
  context 'invalid params' do
    let(:contract_response) { double(failure?: true, errors: {}) }

    it 'returns failure' do
      expect_any_instance_of(Cats::ListContract)
        .to receive(:call).and_return(contract_response)

      result = described_class.({})

      expect(result.success?).to be_falsey
    end
  end

  context 'valid params' do
    let(:contract_response) { double(failure?: false, to_h: true) }
    let(:cats_list) { [Faker::String.random(length: 4)] }

    it 'returns failure' do
      expect_any_instance_of(Cats::ListContract)
        .to receive(:call).and_return(contract_response)

      expect(Cats::ManagerService).to receive(:call).and_return(cats_list)

      result = described_class.({})

      expect(result.success?).to be_truthy
      expect(result.data).to eq(cats_list)
    end
  end
end





