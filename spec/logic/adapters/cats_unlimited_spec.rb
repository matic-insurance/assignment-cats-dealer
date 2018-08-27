require 'rails_helper'

describe Adapters::CatsUnlimited do
  let(:cat_name) { 'Cat1' }
  let(:cat_price) { 100 }
  let(:cat_location) { 'Lviv' }
  let(:cat_image) { 'http://google.com/cat.jpg' }
  let(:input_cats) do
    [
      {"name" => cat_name, "price" => cat_price, "location" => cat_location, "image" => cat_image},
      {"name" => 'Some Other Cat', "price" => 200, "location" => 'Kyiv', "image" => 'http://google.com/kitty.jpg'}
    ]
  end
  let(:instances) { described_class.instantiate(input_cats) }
  let(:instance) { instances.first }

  it 'creates 2 instances of CatsUnlimited class' do
    expect(instances.map(&:class)).to eq Array.new(2){ Adapters::CatsUnlimited }
  end

  it "returns cat's name" do
    expect(instance.name).to eq cat_name
  end

  it "returns cat's price" do
    expect(instance.price).to eq cat_price
  end

  it "returns cat's location" do
    expect(instance.location).to eq cat_location
  end

  it "returns cat's image url" do
    expect(instance.image_url).to eq cat_image
  end
end