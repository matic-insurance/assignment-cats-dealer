require 'rails_helper'

describe 'api/names', type: :request do
  let!(:cat1) { create(:cat, name: 'breed_1') }
  let!(:cat2) { create(:cat, name: 'breed_2') }
  let!(:cat3) { create(:cat, name: 'breed_3') }

  it 'renders correct response with all cats names' do
    get '/api/names'

    expect(response.content_type).to eq 'application/json'
    json_body = JSON.parse(response.body)
    expect(json_body.count).to eq 3
    expect(json_body.kind_of?(Array)).to eq true
    expect(json_body[0]).to eq 'breed_1'
    expect(json_body[1]).to eq 'breed_2'
    expect(json_body[2]).to eq 'breed_3'
  end
end
