require 'rails_helper'
require 'cat'

describe Cat do
  it 'initializes from params' do
    params = {
      breed: 'breed1',
      location: 'location1',
      price: 15,
      shop: 'shop1',
      image: 'image1'
    }
    cat = described_class.new(params)
    expect(cat.breed).to eq params[:breed]
    expect(cat.price).to eq params[:price]
    expect(cat.shop).to eq params[:shop]
    expect(cat.image).to eq params[:image]
  end

  it 'converts price to float' do
    params = {
      breed: 'breed1',
      location: 'location1',
      price: '15.3',
      shop: 'shop1',
      image: 'image1'
    }
    cat = described_class.new(params)
    expect(cat.price).to eq 15.3
  end

  it 'converts price to integer 0' do
    params = {
      breed: 'breed1',
      location: 'location1',
      price: '0.0',
      shop: 'shop1',
      image: 'image1'
    }
    cat = described_class.new(params)
    expect(cat.price).to eq 0
  end

  it 'initializes missing params as nil' do
    params = {
      breed: 'breed1',
      shop: 'shop1',
      image: 'image1'
    }
    cat = described_class.new(params)
    expect(cat.price).to be_nil
    expect(cat.location).to be_nil
  end

  it 'converts price to_i' do
    params = {
      breed: 'breed1',
      shop: 'shop1',
      image: 'image1'
    }
    cat = described_class.new(params)
    expect(cat.price).to be_nil
    expect(cat.location).to be_nil
  end
end
