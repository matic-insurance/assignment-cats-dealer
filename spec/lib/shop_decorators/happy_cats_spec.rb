require 'rails_helper'

describe ShopDecorators::HappyCats do
  context 'when decorate hash items' do
    subject(:decorator) { described_class.new(items) }

    let(:item) do
      {
        title: 'title',
        cost: 0.5,
        location: 'location',
        img: 'img'
      }
    end
    let(:decorated_item) do
      {
        name: item[:title],
        price: item[:cost],
        location: item[:location],
        image: item[:img]
      }
    end
    let(:items) { {cats: {cat: [item]}} }

    it 'decorate' do
      expect(decorator.decorate).to eq [decorated_item]
    end
  end
end
