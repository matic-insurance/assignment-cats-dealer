require 'rails_helper'

RSpec.describe HappyCatsAdapter, vcr: { cassette_name: 'all_happy_cats' } do
  describe '#fetch_all' do
    subject { described_class.new.fetch_all }

    it 'returns all cats' do
      expect(subject.size).to eq 10
    end

    it 'maps response to our names' do
      expect(subject.first).to include({
        breed: 'American Curl',
        price: 650.0,
        location: 'Odessa',
        image: a_string_starting_with('https')
      })
    end

    it 'convers price into float' do
      expect(subject.first[:price]).to eq 650.0
    end
  end
end
