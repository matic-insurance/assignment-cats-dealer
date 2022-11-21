# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatsFilter, type: :filter do
  describe '#result' do
    subject(:filtered_cats) { described_class.new(params).result }

    before do
      allow(CatsFetchService).to receive(:call).and_return(list_of_cats)
    end

    let(:list_of_cats) do
      [
        Cat.new(type: 'Siamese', price: 40.0, location: 'Kharkiv', image: 'img_url', shop_name: 'Happy Cats'),
        Cat.new(type: 'Bobtail', price: 50.0, location: 'Lviv', image: 'img_url', shop_name: 'Happy Cats'),
        Cat.new(type: 'Grumpy', price: 60.0, location: 'Odessa', image: 'img_url', shop_name: 'Cats Unlimited'),
        Cat.new(type: 'Siamese', price: 40.0, location: 'Odessa', image: 'img_url', shop_name: 'Cats Unlimited'),
        Cat.new(type: 'Bobtail', price: 30.0, location: 'Lviv', image: 'img_url', shop_name: 'Cats Unlimited'),
        Cat.new(type: 'Grumpy', price: 10.0, location: 'Lviv', image: 'img_url', shop_name: 'Cats Unlimited')
      ]
    end

    [
      # [params, best_price, cats_count]
      [{ type: '', location: '' }, 10.0, 6],
      [{ type: nil, location: nil }, 10.0, 6],
      [{}, 10.0, 6],
      [{ type: 'bobtail', location: 'lviv' }, 30.0, 2],
      [{ type: 'Siamese' }, 40.0, 2],
      [{ location: 'Kharkiv' }, 40.0, 1]
    ].each do |parameters, best_price, cats_count|
      context "when parameters #{parameters}" do
        let(:params) { parameters }

        it { expect(filtered_cats.first.price).to eq(best_price) }
        it { expect(filtered_cats.size).to eq(cats_count) }
      end
    end

    context 'when no corresponding results found' do
      let(:params) do
        {
          type: 'bob tail',
          location: 'lviv'
        }
      end

      it { is_expected.to be_empty }
    end
  end
end
