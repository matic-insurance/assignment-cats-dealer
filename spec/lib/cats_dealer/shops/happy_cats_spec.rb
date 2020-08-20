require 'rails_helper'

RSpec.describe CatsDealer::Shops::HappyCats do
  let(:instance) { described_class.new }

  describe '#parse' do
    subject { instance.send(:parse, data) }
    let(:data) { "<?xml version=\"1.0\" encoding=\"UTF-8\"?><cats><cat><title>Test breed</title><cost>100</cost><location>Lviv</location><img>https://test.jpg</img></cat></cats>" }
    let(:expected_result) do
      {
        title: 'Test breed',
        cost: "100",
        location: 'Lviv',
        img: 'https://test.jpg'
      }
    end

    it 'returns parsed hash' do
      expect(subject).to eq(expected_result)
    end
  end

  describe '#serialize' do
    subject { instance.send(:serialize, data) }
    let(:data) do
      {
        title: 'Test breed',
        cost: "100",
        location: 'Lviv',
        img: 'https://test.jpg'
      }
    end

    let(:expected_result) do
      {
        breed: 'Test breed',
        price: 100.0,
        location: 'Lviv',
        image: 'https://test.jpg'
      }
    end

    it 'returns correct serialized data' do
      expect(subject).to eq(expected_result)
    end
  end
end
