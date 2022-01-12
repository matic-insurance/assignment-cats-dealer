require 'rails_helper'

describe Api::V1::CatsDealersController do
  describe 'GET #index' do
    before do
      allow(CatsDealers::FetchService).to receive(:call) { all_cats }
      allow(CatsDealers::SearchService).to receive(:call).with(all_cats, params) { matched_cats }

      get :index, params: params
    end

    let(:params) { {location: 'Lviv'} }
    let(:all_cats) do
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
    let(:matched_cats) do
      [
        {breed: 'Abyssin', price: 500, location: 'Lviv', image: 'https://test.com/abyssin2.jpg'},
        {breed: 'Maine Coon', price: 500, location: 'Lviv', image: 'https://test.com/mainecoon1.jpg'},
        {breed: 'Abyssin', price: 650, location: 'Lviv', image: 'https://test.com/abyssin1.jpg'}
      ]
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all matched items' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
