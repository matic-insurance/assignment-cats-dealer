require 'rails_helper'

RSpec.describe CatsDealer::Shops::CatsUnlimited do
  let(:instance) { described_class.new }

  describe '#parse' do
    subject { instance.send(:parse, data) }
    let(:data) { "[{\"name\":\"Test breed\",\"price\":100,\"location\":\"Lviv\",\"image\":\"https://test.jpg\"}]" }
    let(:expected_result) do
      [
        {
          name: 'Test breed',
          price: 100,
          location: 'Lviv',
          image: 'https://test.jpg'
        }
      ]
    end

    it 'returns parsed hash' do
      expect(subject).to eq(expected_result)
    end
  end

  describe '#serialize' do
    subject { instance.send(:serialize, data) }
    let(:data) do
      {
        name: 'Test breed',
        price: 100,
        location: 'Lviv',
        image: 'https://test.jpg'
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
