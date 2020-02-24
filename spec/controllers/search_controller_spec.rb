require 'rails_helper'

describe SearchController do
  context 'when GET #new' do
    before { get 'new' }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @search_form' do
      expect(assigns(:search_form)).to be_a(SearchForm)
    end
  end

  context 'when POST #create' do
    context 'with invalid params' do
      let(:search_params) { {cats_type: 'fake', user_location: 'fake'} }

      before { post('create', params: {search: search_params}) }

      it 'render #new' do
        expect(response).to render_template(:new)
      end
    end

    context 'when redirect to correct path' do
      let(:search_params) { {cats_type: 'bengal', user_location: 'lviv'} }
      let(:item) do
        {
          name: 'name',
          location: 'location',
          price: 0.1,
          image: 'image'
        }
      end
      let(:search_id) { 'search_id' }
      let(:items) { [item] }
      let(:result) { Struct.new(:search_id, :items).new(search_id, items) }
      let(:perform) { Struct.new(:perform).new(result) }

      let(:action_controller_params) do
        ActionController::Parameters.new(search_params)
                                    .permit(*search_params.keys)
      end

      before do
        allow(SearchService).to receive(:new)
          .with(search_params: action_controller_params).and_return(perform)

        post('create', params: {search: search_params})
      end

      it 'redirect to result' do
        expect(response).to redirect_to action: :result, search_id: search_id
      end
    end

    context 'when redirect to empty result action' do
      let(:search_id) { 'search_id' }
      let(:search_params) { {cats_type: 'bengal', user_location: 'lviv'} }
      let(:items) { [] }

      let(:action_controller_params) do
        ActionController::Parameters.new(search_params)
                                    .permit(*search_params.keys)
      end

      let(:result) { Struct.new(:search_id, :items).new(search_id, items) }
      let(:perform) { Struct.new(:perform).new(result) }

      before do
        allow(SearchService).to receive(:new)
          .with(search_params: action_controller_params).and_return(perform)

        post('create', params: {search: search_params})
      end

      it 'empty result' do
        expect(response).to redirect_to action: :empty_result,
                                        search_id: search_id
      end
    end
  end

  context 'when GET #result' do
    let(:search_id) { 'search_id' }
    let(:item) do
      {
        name: 'name',
        location: 'location',
        price: 0.1,
        image: 'image'
      }
    end
    let(:items) { [item] }
    let(:result_struct) { Struct.new(:search_id, :items).new(search_id, items) }
    let(:result) { Struct.new(:result).new(result_struct) }

    before do
      allow(SearchService).to receive(:new)
        .with(search_id: search_id).and_return(result)

      get('result', params: {search_id: search_id})
    end

    it 'assigns @result' do
      expect(assigns(:result)).to be_a(SearchResultRepresenter)
    end

    context 'when redirect to empty result' do
      let(:items) { [] }

      it 'empty result' do
        expect(response).to redirect_to action: :empty_result,
                                        search_id: search_id
      end
    end
  end
end
