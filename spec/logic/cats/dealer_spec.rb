require 'rails_helper'

describe 'Dealer API' do
  it 'responds to public API methods' do
    expect(::Cats::Dealer).to respond_to(:sync_cats)
    expect(::Cats::Dealer).to respond_to(:shops)
    expect(::Cats::Dealer).to respond_to(:find_cats)
  end

  describe '.sync_cats' do
    subject { ::Cats::Dealer.sync_cats }

    it 'should delegate method call' do
      expect(::Cats::Dealer::Syncronizer).to receive(:sync_cats)

      subject
    end
  end

  describe '.shops' do
    subject { ::Cats::Dealer.shops }

    it 'should delegate method call' do
      expect(::Cats::Dealer::ShopsManager).to receive(:shops)

      subject
    end
  end

  describe '.find_cats' do
    let(:location) { 'Lviv' }
    let(:breed)    { 'Abyssin' }

    subject { ::Cats::Dealer.find_cats(location: location, breed: breed) }

    it 'should query matched cats from cache' do
      expect(Cat).to receive(:where).with(location: location, breed: breed)

      subject
    end
  end
end
