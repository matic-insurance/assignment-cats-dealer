require 'rails_helper'

describe BestPrice do
  subject { described_class.new(cats_list: cats_list).call }

  let(:cat1) do
    Cat.new(name: Types::NAMES.sample, location: Types::LOCATIONS.sample, image: 'https://test', price: 500)
  end

  let(:cat2) do
    Cat.new(name: Types::NAMES.sample, location: Types::LOCATIONS.sample, image: 'https://test', price: 490)
  end

  let(:cat3) do
    Cat.new(name: Types::NAMES.sample, location: Types::LOCATIONS.sample, image: 'https://test', price: 515)
  end

  let(:cats_list) { [cat1, cat2, cat3] }

  it { is_expected.to eq 490 }
end
