require 'rails_helper'

RSpec.describe CatsFinder do
  describe '#call' do
    subject(:cats) { described_class.new.call }

    it 'returns cats from all services', cassette_names: %w(all_cats_unlimited all_happy_cats) do
      expect(cats.size).to eq 21

      expect(cats.first).to include({
        breed: 'Abyssin',
        price: 500.0,
        location: 'Lviv',
        image: a_string_starting_with('https')
      })

      expect(cats[11]).to include({
        breed: 'American Curl',
        price: 650.0,
        location: 'Odessa',
        image: a_string_starting_with('https')
      })
    end

    context 'when Happy Cats service responded with error 3 times in a row', cassette_names: %w(all_cats_unlimited all_happy_cats_3_times) do
      it 'retries 3 times or before successful response' do
        expect(cats.size).to eq 21
      end
    end

    context 'when Unlimited Cats service responded with error 3 times in a row', cassette_names: %w(all_cats_unlimited_3_times all_happy_cats) do
      it 'retries 3 times or before successful response' do
        expect(cats.size).to eq 21
      end
    end
  end
end
