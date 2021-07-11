require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  context 'when third-party API responds with empty array' do
    it 'should return an empty array' do
      VCR.use_cassette('cats_empty') do
        get root_path

        response_body = JSON.parse(response.body)

        expect(response_body).to eq([])
      end
    end
  end

  context 'when CatsUnlimited API fails' do
    it 'raise error' do
      VCR.use_cassette('cats_unlimited_server_error') do
        expect { get root_path }.
          to raise_error(Cats::CatsUnlimitedAdapter::ServerError)
      end
    end
  end

  context 'when HappyCats API fails' do
    it 'raise error' do
      VCR.use_cassette('happy_cats_server_error') do
        expect { get root_path }.
          to raise_error(Cats::HappyCatsAdapter::ServerError)
      end
    end
  end

  context 'when everything ok' do
    context 'when no request params provided' do
      it 'should return array with cats' do
        VCR.use_cassette('cats_success') do
          get root_path

          response_body = JSON.parse(response.body)

          expect(response_body.count).to eq(21) # full amount of cats from both apis
        end
      end
    end

    context 'when location param provided' do
      it 'should return results for user location' do
        VCR.use_cassette('cats_success') do
          get root_path(location: 'Lviv')

          response_body = JSON.parse(response.body)

          expect(response_body.count).to eq(5) # amount of cats from lviv
          response_body.each do |item|
            expect(item['location'].downcase).to eq('lviv')
          end
        end
      end
    end

    context 'when breed param provided' do
      it 'should return results for requested breed' do
        VCR.use_cassette('cats_success') do
          get root_path(breed: 'Bengal')

          response_body = JSON.parse(response.body)

          expect(response_body.count).to eq(3) # amount of cats for requested breed

          response_body.each do |item|
            expect(item['breed'].downcase).to eq('bengal')
          end
        end
      end
    end

    context 'when location and breed param provided' do
      it 'should return results for requested params' do
        VCR.use_cassette('cats_success') do
          get root_path(breed: 'Bengal', location: 'Kyiv')

          response_body = JSON.parse(response.body)

          expect(response_body.count).to eq(2) # amount of cats for requested breed and location

          response_body.each do |item|
            expect(item['breed'].downcase).to eq('bengal')
            expect(item['location'].downcase).to eq('kyiv')
            expect(item['price']).to be_a(Integer)
            expect(item['image']).to be_present
          end
        end
      end

      it 'should return cats sorted by price (first - cheapest)' do
        VCR.use_cassette('cats_success') do
          get root_path(breed: 'Bengal', location: 'Kyiv')

          response_body = JSON.parse(response.body)

          expect(response_body.count).to eq(2) # amount of cats for requested breed and location

          first_item = response_body.first
          second_item = response_body.second

          expect(first_item['price'] < second_item['price']).to be(true)
        end
      end
    end
  end
end
