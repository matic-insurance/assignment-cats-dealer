require 'rails_helper'

describe CatsDealers::SearchService do
  subject(:search_result) { described_class.call(collection, parameters) }

  let(:collection) do
    [
      {breed: 'Abyssin', price: 650, location: 'Lviv', image: 'https://test.com/abyssin1.jpg'},
      {breed: 'Abyssin', price: 500, location: 'Lviv', image: 'https://test.com/abyssin2.jpg'},
      {breed: 'Abyssin', price: 500, location: 'Kyiv', image: 'https://test.com/abyssin3.jpg'},
      {breed: 'Maine Coon', price: 500, location: 'Lviv', image: 'https://test.com/mainecoon1.jpg'},
      {breed: 'Maine Coon', price: 20, location: 'Kyiv', image: 'https://test.com/mainecoon2.jpg'},
      {breed: 'Bengal', price: 700, location: 'Kyiv', image: 'https://test.com/bengal.jpg'},
      {breed: 'Siamese', price: 500, location: 'Kharkiv', image: 'https://test.com/bengal.jpg'}
    ]
  end
  let(:parameters) { {breed: '', location: '', price: ''} }

  describe '#call' do
    context 'when price, breed and location specified' do
      before { parameters.merge!(breed: 'Abyssin', location: 'Lviv', price: 650) }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(1)
        expect(search_result.sample[:location]).to eq('Lviv')
        expect(search_result.sample[:breed]).to eq('Abyssin')
        expect(search_result.first[:price]).to eq(650)
      end
    end

    context 'when breed and location specified' do
      before { parameters.merge!(breed: 'Abyssin', location: 'Lviv') }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(2)
        expect(search_result.sample[:location]).to eq('Lviv')
        expect(search_result.sample[:breed]).to eq('Abyssin')
        expect(search_result.first[:price]).to eq(500)
      end
    end

    context 'when breed and price specified' do
      before { parameters.merge!(breed: 'Abyssin', price: 500) }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(2)
        expect(search_result.sample[:breed]).to eq('Abyssin')
        expect(search_result.sample[:price]).to eq(500)
      end
    end

    context 'when location and price specified' do
      before { parameters.merge!(location: 'Kharkiv', price: 500) }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(1)
        expect(search_result.sample[:location]).to eq('Kharkiv')
        expect(search_result.first[:price]).to eq(500)
      end
    end

    context 'when breed specified only' do
      before { parameters.merge!(breed: 'Maine Coon') }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(2)
        expect(search_result.sample[:breed]).to eq('Maine Coon')
        expect(search_result.first[:price]).to eq(20)
      end
    end

    context 'when price specified only' do
      before { parameters.merge!(price: 20) }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(1)
        expect(search_result.first[:price]).to eq(20)
      end
    end

    context 'when location specified only' do
      before { parameters.merge!(location: 'Lviv') }

      it 'returns all cats for specified parameters' do
        expect(search_result.length).to eq(3)
        expect(search_result.sample[:location]).to eq('Lviv')
        expect(search_result.first[:price]).to eq(500)
      end
    end

    context 'when location not found' do
      let(:imput_parameters) { {location: 'Odessa'} }

      it 'returns an empty list' do
        expect(search_result).to be_empty
      end
    end
  end
end
