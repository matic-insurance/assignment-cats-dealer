require 'rails_helper'

describe Adapters::HappyCats do
  let(:cat_title) { 'Cat1' }
  let(:cat_cost) { 100 }
  let(:cat_location) { 'Lviv' }
  let(:cat_img) { 'http://google.com/cat.jpg' }
  let(:input_cats) do
    [
      {'title' => cat_title, 'cost' => cat_cost, 'location' => cat_location, 'img' => cat_img},
      {'title' => 'Some Other Cat', 'cost' => 200, 'location' => 'Kyiv', 'img' => 'http://google.com/kitty.jpg'}
    ]
  end
  let(:instances) { described_class.instantiate(input_cats) }
  let(:instance) { instances.first }

  it 'creates 2 instances of HappyCats class' do
    expect(instances.map(&:class)).to eq Array.new(2) { described_class }
  end

  it "returns cat's name" do
    expect(instance.name).to eq cat_title
  end

  it "returns cat's price" do
    expect(instance.price).to eq cat_cost
  end

  it "returns cat's location" do
    expect(instance.location).to eq cat_location
  end

  it "returns cat's image url" do
    expect(instance.image_url).to eq cat_img
  end
end
