require 'rails_helper'

describe SearchResultRepresenter do
  context 'when represent works' do
    subject(:representer) { described_class.new(search_result) }

    let(:items) { [1, 2, 3] }
    let(:search_result) { Struct.new(:items).new(items) }
    let(:best_price_value) { 3.0 }
    let(:calculate_struct) { Struct.new(:calculate).new(best_price_value) }

    it 'cats_list returns items' do
      expect(representer.cats_list).to eq items
    end

    it 'best_price returns best_price_value' do
      allow(BestPriceCalculationService).to receive(:new)
        .with(items).and_return(calculate_struct)

      expect(representer.best_price).to eq best_price_value
    end
  end
end
