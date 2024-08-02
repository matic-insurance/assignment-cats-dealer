require 'rails_helper'

describe CatAdapter do
  let(:shop_name) { 'Example Shop' }
  let(:adapter) { described_class.new(shop_name:) }

  describe '#initialize' do
    it 'sets the shop_name instance variable' do
      expect(adapter.instance_variable_get(:@shop_name)).to eq(shop_name)
    end
  end

  describe '#adapt' do
    let(:response) { [{title: '', cost: ''}, {title: '', cost: ''}] }

    it 'maps the response using transform_item' do
      expect(response).to receive(:map).and_call_original
      expect(adapter).to receive(:transform_item).exactly(response.size).times

      adapter.adapt(response)
    end
  end

  describe '#transform_item' do
    let(:attributes) { %i[title cost location image] }
    let(:random_keys) { attributes.sample(4) }
    let(:mapping) do
      random_keys.zip(attributes.sample(4)).to_h
    end

    before do
      allow(adapter).to receive(:mapping).and_return(mapping)
    end

    it 'transforms item according to mapping and adds shop_name' do
      item = {
        title: 'American Curl',
        cost: 133,
        location: 'Odessa',
        image: 'http://example.com/example.jpg'
      }

      transformed_item = adapter.send(:transform_item, item)

      expected_transformed_item = random_keys.index_with do |key|
        item[mapping[key]]
      end.merge(shop_name:)

      expect(transformed_item).to eq(expected_transformed_item)
    end
  end

  describe '#mapping' do
    it 'raises NotImplementedError' do
      expect do
        adapter.send(:mapping)
      end.to raise_error(NotImplementedError, /cannot respond to/)
    end
  end
end
