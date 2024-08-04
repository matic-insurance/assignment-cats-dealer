# frozen_string_literal: true

require 'rails_helper'
require 'vcr'

RSpec.describe CatFinderAdaptors::CatsUnlimitedAdaptor, :vcr do
  describe '.fetch_data' do
    context 'when the request is successful' do
      it 'returns parsed JSON data', vcr: { cassette_name: 'cats_unlimited_success' } do
        VCR.use_cassette('cats_unlimited_success') do
          expect(described_class.fetch_data).not_to be_empty
        end
      end
    end

    context 'when the request fails' do
      let(:failed_response) { double('response', is_a?: false, message: 'Internal Server Error') }

      before do
        allow(Net::HTTP).to receive(:get_response).and_return(failed_response)
        allow(Rails.logger).to receive(:error).with(/Failed to fetch data/)
      end

      it 'logs an error and returns an empty array' do
        expect(described_class.fetch_data).to eq([])
      end
    end

    context 'when an exception is raised' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_raise(Net::ReadTimeout)
        allow(Rails.logger).to receive(:error).with(instance_of(String)).with(/Net::ReadTimeout/)
      end

      it 'logs the exception and returns an empty array' do
        expect(described_class.fetch_data).to eq([])
      end
    end
  end
end
