# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatFinderService do
  let(:location) { 'Donezk' }
  let(:cat_type) { 'American Curl' }
  let(:service) { described_class.new(location, cat_type) }

  let(:cats_data) do
    [
      { 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Lviv', 'image' => 'https://olxua-ring07' },
      { 'cat_type' => 'Siberian', 'price' => 300, 'location' => 'Donezk', 'image' => 'https://olxua-ring08' },
      { 'cat_type' => 'American Curl', 'price' => 400, 'location' => 'Donezk', 'image' => 'https://olxua-ring09' },
      { 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Lviv', 'image' => 'https://olxua-ring10' },
      { 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Lviv', 'image' => 'https://olxua-ring01' },
      { 'cat_type' => 'Siberian', 'price' => 300, 'location' => 'Donezk', 'image' => 'https://olxua-ring08' }
    ]
  end

  before { allow(service).to receive(:fetch_all_cats_data).and_return(cats_data) }

  describe '#call' do
    context 'when there are matching cats' do
      context 'when only one cat matched' do
        it 'returns the cat with the lowest price for the given location and cat_type' do
          result = service.call
          expect(result).to eq([{ 'cat_type' => 'American Curl', 'price' => 400, 'location' => 'Donezk', 'image' => 'https://olxua-ring09' }])
        end
      end

      context 'when there are several matches' do
        context 'when there are two or more different cats in all shops with the same cost, location and cat_type' do
          let(:location) { 'Lviv' }
          let(:cat_type) { 'American Curl' }

          it 'returns the cats with the lowest price for the given location and cat_type' do
            result = service.call
            expect(result).to eq([{ 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Lviv', 'image' => 'https://olxua-ring07' },
                                  { 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Lviv', 'image' => 'https://olxua-ring10' },
                                  { 'cat_type' => 'American Curl', 'price' => 450, 'location' => 'Lviv', 'image' => 'https://olxua-ring01' }])
          end
        end

        context 'when there are two or more the same cats from different shops' do
          let(:location) { 'Donezk' }
          let(:cat_type) { 'Siberian' }

          it 'returns the cats with the lowest price for the given location and cat_type' do
            result = service.call
            expect(result).to eq([{ 'cat_type' => 'Siberian', 'price' => 300, 'location' => 'Donezk', 'image' => 'https://olxua-ring08' }])
          end
        end
      end
    end

    context 'when there are no matching cats' do
      let(:cats_data) do
        [
          { 'cat_type' => 'Siberian', 'price' => 300, 'location' => 'Donezk', 'image' => 'https://olxua-ring08' },
          { 'cat_type' => 'British Shorthair', 'price' => 500, 'location' => 'Kyiv', 'image' => 'https://olxua-ring10' }
        ]
      end

      it 'returns nil' do
        result = service.call
        expect(result).to eq([])
      end
    end

    context 'when all adapters return no data' do
      let(:cats_data) { [] }

      it 'raises NoDataAvailableError' do
        expect { service.call }.to raise_error(NoDataAvailableError, 'No data available from any source')
      end
    end

    context 'when adapters return data but no matches for the given location and cat_type' do
      let(:cats_data) do
        [
          { 'cat_type' => 'Siberian', 'price' => 300, 'location' => 'Donezk', 'image' => 'https://olxua-ring08' },
          { 'cat_type' => 'British Shorthair', 'price' => 500, 'location' => 'Kyiv', 'image' => 'https://olxua-ring10' }
        ]
      end

      it 'returns nil because no cats match the given location and cat_type' do
        result = service.call
        expect(result).to eq([])
      end
    end

    context 'when adapters return data but with different locations and cat_types' do
      let(:cats_data) do
        [
          { 'cat_type' => 'Persian', 'price' => 300, 'location' => 'Lviv', 'image' => 'https://olxua-ring08' },
          { 'cat_type' => 'Bengal', 'price' => 600, 'location' => 'Odesa', 'image' => 'https://olxua-ring10' }
        ]
      end

      it 'returns nil because no cats match the given location and cat_type' do
        result = service.call
        expect(result).to eq([])
      end
    end
  end
end
