require 'rails_helper'

describe 'api/locations', type: :request do
  let!(:cat1) { create(:cat, location: 'location_1') }
  let!(:cat2) { create(:cat, location: 'location_2') }
  let!(:cat3) { create(:cat, location: 'location_3') }
  let!(:cat4) { create(:cat, location: 'location_4') }

  it 'renders correct response with all cats locations' do
    get '/api/locations'

    expect(response.content_type).to eq 'application/json'
    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 4
    expect(json_body.kind_of?(Array)).to eq true
    expect(json_body[0]).to eq 'location_1'
    expect(json_body[1]).to eq 'location_2'
    expect(json_body[2]).to eq 'location_3'
    expect(json_body[3]).to eq 'location_4'
  end
end
