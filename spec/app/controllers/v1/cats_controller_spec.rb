# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'expected response' do
  it 'returns expected response status' do
    get :index, params: parameters

    expect(response.status).to eq(expected_response_status)
  end
end

RSpec.describe V1::CatsController, type: :controller do
  describe '#index' do
    before do
      stub_request(:get, 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json')
        .to_return(status: 200, body: '', headers: {})

      stub_request(:get, 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml')
        .to_return(status: 200, body: '', headers: {})
    end

    context 'when no parameters' do
      let(:parameters) { {} }
      let(:expected_response_status) { 200 }

      it_behaves_like 'expected response'
    end

    context 'when parameters permitted' do
      let(:parameters) { { type: 'Cat1', location: 'Lviv' } }
      let(:expected_response_status) { 200 }

      it_behaves_like 'expected response'
    end

    context 'when extra parameters' do
      let(:parameters) { { breed: 'Cat1' } }
      let(:expected_response_status) { 400 }

      it_behaves_like 'expected response'
    end
  end
end
