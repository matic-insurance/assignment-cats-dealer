require 'rails_helper'

describe '/', type: :request do
  it 'renders correct response' do
    get '/'

    expect(response.content_type).to eq 'text/html'
    expect(response.status).to eq 200
  end
end
