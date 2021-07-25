require 'rails_helper'

RSpec.describe CatsUnlimitedAdapter, vcr: { cassette_name: 'all_cats_unlimited' } do
  describe '#fetch_all' do
    subject { described_class.new.fetch_all }

    it 'returns all cats' do
      expect(subject.size).to eq 11
    end

    it 'maps response to our names' do
      expect(subject.first).to include({
        breed: 'Abyssin',
        price: 500.0,
        location: 'Lviv',
        image: a_string_starting_with('https')
      })
    end

    it 'convers price into float' do
      expect(subject.first[:price]).to eq 500.0
    end

    context 'when service responded with error' do
      before do
        stub_request(:get, described_class::API_URL)
          .and_return(status: 500, body: 'Internal Server Error')
      end

      it 'raises ServiceError' do
        expect { subject }.to raise_exception(ApplicationAdapter::ServiceError, 'Internal Server Error')
      end
    end
  end
end
