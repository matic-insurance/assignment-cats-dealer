# frozen_string_literal: true

require 'rails_helper'

describe Cats::LookupBestDeal do
  context 'when filtering are missing' do
    it 'finds cat with minimal price' do
      sources = [double(call: load_source1), double(call: load_source2)]

      result = described_class.new(sources: sources).call

      expect(result.price).to eq(50)
    end
  end

  context 'when filtering by location' do
    it 'finds cat with minimal price' do
      sources = [double(call: load_source1), double(call: load_source2)]

      result = described_class.new(sources: sources).call(location: 'Lviv')

      expect(result.price).to eq(349)
    end
  end

  context 'when filtering by cat_type' do
    it 'finds cat with minimal price' do
      sources = [double(call: load_source1), double(call: load_source2)]

      result = described_class.new(sources: sources).call(cat_type: 'Devon Rex')

      expect(result.price).to eq(70)
    end
  end

  context 'when filtering by cat_type and location' do
    it 'finds cat with minimal price' do
      sources = [double(call: load_source1), double(call: load_source2)]

      result = described_class.new(sources: sources).call(cat_type: 'Devon Rex', location: 'Kharkiv')

      expect(result.price).to eq(70)
    end
  end

  def load_source1
    [
      {
        'name' => 'Abyssin',
        'price' => 500,
        'location' => 'Lviv'
      },
      {
        'name' => 'Devon Rex',
        'price' => 100,
        'location' => 'Kharkiv'
      }
    ].map { |r| ::Cats::Shops::CatsUnlimited.build_record(r) }
  end

  def load_source2
    [
      {
        'name' => 'Bobtail',
        'price' => 349,
        'location' => 'Lviv'
      },
      {
        'name' => 'Devon Rex',
        'price' => 70,
        'location' => 'Kharkiv'
      },
      {
        'name' => 'Maine Coon',
        'price' => 50,
        'location' => 'Kharkiv'
      }
    ].map { |r| ::Cats::Shops::CatsUnlimited.build_record(r) }
  end
end
