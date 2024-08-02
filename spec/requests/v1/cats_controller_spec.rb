require 'rails_helper'

describe V1::CatsController do
  subject do
    request
    response
  end

  describe '#index' do
    let(:request) { get('/v1/cats', params:) }

    context 'when there is no params supplied returns all records' do
      let(:params) { {} }
      let(:expected_response) do
        {data: Shops::FindCheaper::Organize.call(query_params: params).record}
      end

      it 'returns all records' do
        expect(subject).to have_http_status(:ok)
        expect(subject.body).to eq(expected_response.to_json)
      end
    end

    context 'when there are one of the params it returns filtered records' do
      let(:params) { {location: 'Odessa'} }
      let(:expected_response) do
        {data: Shops::FindCheaper::Organize.call(query_params: params).record}
      end

      it 'returns filtered records' do
        expect(subject).to have_http_status(:ok)
        expect(subject.body).to eq(expected_response.to_json)
      end
    end

    context 'when there are both params it returns the cheapest record' do
      let(:params) { {location: 'Persian', name: 'Odessa'} }
      let(:expected_response) do
        {data: Shops::FindCheaper::Organize.call(query_params: params).record}
      end

      it 'returns the cheapest record' do
        expect(subject).to have_http_status(:ok)
        expect(subject.body).to eq(expected_response.to_json)
      end
    end
  end
end
