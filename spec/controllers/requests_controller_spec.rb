require 'rails_helper'

describe RequestsController do
  describe 'GET #new' do
    before { get 'new' }

    it 'renders templates' do
      expect(response).to render_template(:new)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
