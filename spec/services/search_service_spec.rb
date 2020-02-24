require 'rails_helper'

describe SearchService do
  context 'when search methods work correct' do
    let(:search_params) { {test: :my, second: :param} }
    let(:search_id) { SecureRandom.uuid }
    let(:items) { [1, 2, 3] }
    let(:items_struct) { Struct.new(:items).new(items) }

    context 'when call def perform' do
      let(:instance) { described_class.new(search_params: search_params) }
      let(:cache_class) do
        Class.new do
          def self.write(_data); end
        end
      end

      before do
        allow(ShopsConsolidatorService).to receive(:new)
          .with(search_params).and_return(items_struct)

        allow(SearchCacheService).to receive(:new)
          .and_return(cache_class)
      end

      it 'result includes search_id' do
        expect(instance.perform).to respond_to(:search_id)
      end

      it 'result includes items' do
        expect(instance.perform).to respond_to(:items)
      end

      it 'returns consolidation result (items)' do
        expect(instance.perform.items).to eq items
      end
    end

    context 'when call def result' do
      let(:instance) { described_class.new(search_id: search_id) }
      let(:read_struct) { Struct.new(:read).new(items) }

      before do
        allow(SearchCacheService).to receive(:new)
          .and_return(read_struct)
      end

      it 'result includes search_id' do
        expect(instance.result).to respond_to(:search_id)
      end

      it 'result respond to items' do
        expect(instance.result).to respond_to(:items)
      end

      it 'result includes correct items' do
        expect(instance.result.items).to eq items
      end
    end
  end
end
