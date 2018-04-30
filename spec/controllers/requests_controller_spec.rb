require 'rails_helper'

describe RequestsController, type: :controller do
  before(:all) do
    create_list(:cat, 5)
  end

  describe 'GET #new' do
    let(:number_of_lviv_cats) { 5 }
    before { post 'create', params: {location: 'Lviv'} }

    it 'renders result template' do
      expect(response).to be_success
      expect(response).to render_template(:result)
    end

    it 'assigns search results' do
      expect(assigns(:cats_list).sample).to be_a(Cat)
    end
  end

  describe '#search_params' do
    let(:passed_params) do
      ActionController::Parameters.new(
        breed: 'Typical',
        location: '',
        extra_params: 47
      )
    end

    before { allow(controller).to receive(:params).and_return(passed_params) }

    it 'permits only allowed parameters for SearchService' do
      permitted_params = controller.send(:search_params)

      expect(permitted_params[:breed]).to eq('Typical')
      expect(permitted_params).to_not have_key(:location)
      expect(permitted_params).to_not have_key(:extra_params)
    end
  end

  describe '#search_service' do
    it 'returns SearchService for cats' do
      expect(controller.send(:search_service)).to eq(CatsServices::SearchService)
    end
  end
end
