require 'rails_helper'

describe 'api/cats', type: :request do
  let!(:cat_lowest_price) { create(:cat, price: 20, location: 'location_1', name: 'breed_1') }
  let!(:cat_highest_price) { create(:cat, price: 1000, location: 'location_2', name: 'breed_2') }

  it 'renders correct response' do
    get '/api/cats'

    expect(response.content_type).to eq 'application/json'
    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 2
  end

  it 'renders cats with correct order' do
    get '/api/cats'

    json_body = JSON.parse(response.body)
    expect(json_body[0]['price']).to eq 20
    expect(json_body[1]['price']).to eq 1000
  end

  it 'renders cats filtered by location' do
    get '/api/cats', params: { location: 'location_1' }

    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 1
    expect(json_body[0]['location']).to eq 'location_1'

    get '/api/cats', params: { location: 'location_2' }

    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 1
    expect(json_body[0]['location']).to eq 'location_2'
  end

  it 'renders cats filtered by name' do
    get '/api/cats', params: { name: 'breed_1' }

    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 1
    expect(json_body[0]['name']).to eq 'breed_1'

    get '/api/cats', params: { name: 'breed_2' }

    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 1
    expect(json_body[0]['name']).to eq 'breed_2'
  end

  it 'renders cats filtered by name and location' do
    get '/api/cats', params: { name: 'breed_1', location: 'location_1' }

    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 1
    expect(json_body[0]['name']).to eq 'breed_1'
    expect(json_body[0]['location']).to eq 'location_1'

    get '/api/cats', params: { name: 'breed_2', location: 'location_2' }

    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 1
    expect(json_body[0]['name']).to eq 'breed_2'
    expect(json_body[0]['location']).to eq 'location_2'
  end

  it 'renders blank array when filtered cats does not exists' do
    get '/api/cats', params: { name: 'breed_1', location: 'location_2' }

    expect(response.body).to eq('[]')
  end
end
