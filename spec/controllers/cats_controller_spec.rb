require 'rails_helper'

describe CatsController do
  let!(:cat) { create :cat }

  def cat_to_row(cat)
    [
      cat.breed.name,
      cat.location.name,
      cat.cost,
      cat.image
    ]
  end

  describe 'GET #index' do
    before { get 'index' }

    it 'renders grid with cats' do
      expect(assigns[:grid].rows.first).to eq(cat_to_row(cat))
    end

    it 'renders templates' do
      expect(response).to render_template(:index)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
