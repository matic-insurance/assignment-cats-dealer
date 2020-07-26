require 'rails_helper'

describe Cats::FilterService do
  context 'cats list from store' do
    3.times do |index|
      let("cat#{index}") do
        double(
          location: Faker::Address.city,
          title: Faker::String.random(length: 4),
          price: Faker::Number.number(digits: 3)
        )
      end
    end

    let(:cats_type) { Faker::String.random(length: 4) }
    let(:user_location) { Faker::Address.city }

    let(:cheap_cat) do
      double(
        location: user_location,
        title: cats_type,
        price: Faker::Number.number(digits: 2)
      )
    end

    let(:expencive_cat) do
      double(
        location: user_location,
        title: cats_type,
        price: Faker::Number.number(digits: 4)
      )
    end

    let(:cats_list) { [cat0, cat1, cat2, expencive_cat, cheap_cat] }

    let(:params) do
      {
        cats_list: cats_list,
        cats_type: cats_type,
        user_location: user_location
      }
    end

    subject { described_class.(params) }

    it 'fiter & sort by min price' do
      expect(subject).to eq([cheap_cat, expencive_cat])
    end
  end
end
