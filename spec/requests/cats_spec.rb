require 'rails_helper'

RSpec.describe 'Cats' do
  describe 'GET /cats' do
    subject { get '/cats' }

    it 'returns all cats' do
      VCR.use_cassettes([{ name: 'all_cats_unlimited' }, { name: 'all_happy_cats' }]) do
        subject

        body = JSON.parse(response.body)

        expect(body.size).to eq 21
        expect(response.body).to include_json(
          [{
            breed: 'Abyssin',
            price: 500,
            location: 'Lviv',
            image: a_string_starting_with('https')
          }]
        )
      end
    end

    context 'when no cats found by location' do
      it 'returns empty array' do
        get '/cats', params: { location: 'undefined' }

        expect(response.body).to eq '[]'
      end
    end

    context
  end
end
