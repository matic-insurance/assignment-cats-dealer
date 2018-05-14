require 'rails_helper'

describe CatsController do
  describe 'GET #index' do
    before { get 'index' }

    it 'renders templates' do
      expect(response).to render_template(:index)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #count' do
    before { get 'count' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
