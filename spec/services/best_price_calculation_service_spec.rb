require 'rails_helper'

describe BestPriceCalculationService do
  context 'when calculate best price' do
    subject(:best_price_calculation) { described_class.new(items) }

    let(:best_price_item) { {price: 1.0} }
    let(:worst_price_item) { {price: 2.0} }
    let(:items) { [best_price_item, worst_price_item] }

    it 'returns item with best price' do
      expect(best_price_calculation.calculate).to eq best_price_item
    end
  end
end
