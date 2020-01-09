require 'rspec'
require 'rails_helper'
require_relative '../../../app/lib/parsing/product_parser'
require_relative '../../product_helper'

RSpec.configure do |c|
  c.include ProductHelper
end

describe Parsing::ProductParser do
  fixtures :shops
  context 'when parsing valid shops' do
    describe 'json_shop (Happy Cats)' do
      let(:shop_type) { :json_shop }

      let(:items) { described_class.new(shops(shop_type)).call }

      it 'check columns format' do
        items.each do |item|
          check_item_attribute_type(item, :price, Float)
        end
      end

      it 'check columns values' do
        items.each do |item|
          check_item_attribute_value(item, :shop_id, shops(shop_type).id)
          check_item_attribute_value(item, :request_id, nil)
        end
      end
    end

    describe 'xml_shop (Cats Unlimited)' do
      let(:shop_type) { :xml_shop }

      let(:items) { described_class.new(shops(shop_type)).call }

      it 'check columns format' do
        items.each do |item|
          check_item_attribute_type(item, :price, Float)
        end
      end

      it 'check columns values' do
        items.each do |item|
          check_item_attribute_value(item, :shop_id, shops(shop_type).id)
          check_item_attribute_value(item, :request_id, nil)
        end
      end
    end
  end

  context 'when parsing shop with not supported format' do
    describe 'csv_shop' do
      let(:shop_type) { :csv_shop }

      it 'raises an error because format is not supported' do
        expect { described_class.new(shops(shop_type)).call }.to raise_exception(RuntimeError)
      end
    end
  end
end
