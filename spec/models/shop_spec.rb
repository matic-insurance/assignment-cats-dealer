require 'rails_helper'
require 'shop'

describe Shop do
  before do
    @config = spy('delegate')
  end

  context 'delegates to correct handler' do
    it 'should get all required data from config' do
      Shop.new(@config)
      expect(@config).to have_received(:wrapper).once
      expect(@config).to have_received(:name).once
      expect(@config).to have_received(:parser).once
      expect(@config).to have_received(:enricher).once
      expect(@config).to have_received(:mapper).once
      expect(@config).to have_received(:client).once
    end

    it 'should call fetch on client' do
      @delegated = spy('client')
      allow(@config).to receive(:client).and_return(@delegated )
      shop = Shop.new(@config)
      shop.fetch
      expect(@delegated ).to have_received(:fetch).once
    end

    it 'should call parse om parser' do
      @delegated  = spy('client')
      allow(@config).to receive(:parser).and_return(@delegated)
      shop = Shop.new(@config)
      shop.parse
      expect(@delegated ).to have_received(:parse).once
    end

    it 'should call wrap on wrap' do
      @delegated  = spy('client')
      allow(@config).to receive(:wrapper).and_return(@delegated)
      shop = Shop.new(@config)
      shop.wrap
      expect(@delegated ).to have_received(:wrap).once
    end

    it 'should call map_fields to mapper' do
      @delegated  = spy('client')
      allow(@config).to receive(:mapper).and_return(@delegated)
      shop = Shop.new(@config)
      shop.map_fields
      expect(@delegated ).to have_received(:map_fields).once
    end

    it 'should call enrich to enricher' do
      @delegated  = spy('client')
      allow(@config).to receive(:enricher).and_return(@delegated)
      shop = Shop.new(@config)
      shop.enrich
      expect(@delegated ).to have_received(:enrich).once
    end
  end

  context 'products' do
    it 'should fetch wrap and convert results' do
      shop = Shop.new(@config)
      results = JSON.generate([{"id" => 1}, {"id" => 2}])
      allow(shop).to receive(:fetch).and_return(results)
      allow(shop).to receive(:parse) do |res|
        JSON.parse(res)
      end
      allow(shop).to receive(:convert) do |product|
        product['id'] = product['id'] + 1
        product
      end
      expect(shop.products).to eq [{"id" => 2}, {"id" => 3}]
    end
  end

  context 'convert' do
    it 'should map_fields enrich and wrap' do
      shop = Shop.new(@config)
      product = {breed: 'breed', location: 'location'}

      allow(shop).to receive(:map_fields).and_return(product)
      allow(shop).to receive(:enrich) do |prod|
        prod[:shop] = 'shop'
        prod
      end
      allow(shop).to receive(:wrap) do |prod|
        Cat.new(prod)
      end

      converted = shop.convert(product)
      expect(converted.breed).to eq 'breed'
      expect(converted.location).to eq 'location'
      expect(converted.shop).to eq 'shop'
    end
  end
end