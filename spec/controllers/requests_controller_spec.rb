require 'rails_helper'

describe RequestsController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it 'return 200 status' do
      expect(subject.status).to eq(200)
    end

    it 'renders the index template' do
      expect(subject).to render_template(:index)
    end
  end
end
