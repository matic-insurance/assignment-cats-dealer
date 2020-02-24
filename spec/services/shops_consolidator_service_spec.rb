require 'rails_helper'

describe ShopsConsolidatorService do
  context 'when consolidator works correct' do
    subject(:consolidator_service) { described_class.new(filter_params) }

    let(:filter_params) { {test: :my, second: :param} }
    let(:items) { [1, 2, 3, 4] }
    let(:shop) { Struct.new(:items).new(items) }

    before do
      allow(Shop).to receive(:new).and_return(shop)
    end

    it 'result includes correct items' do
      expect(consolidator_service.items.uniq.sort).to eq items
    end
  end
end
