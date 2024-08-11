require 'rails_helper'
require 'webmock/rspec'
require 'timecop'

RSpec.describe HttpService do
  let(:url) { 'https://example.com' }
  let(:http_service) { described_class.new }

  before do
    allow(Rails.logger).to receive(:error)
    allow(http_service).to receive(:sleep) # Stub sleep so it doesn't delay the tests
  end

  describe '#get' do
    context 'when the request is successful' do
      it 'returns the response body' do
        stub_request(:get, url).to_return(status: 200, body: 'Success')

        response = http_service.get(url)

        expect(response).to eq('Success')
      end
    end

    context 'when a timeout occurs and retries are successful' do
      it 'retries the request and returns the response body' do
        stub_request(:get, url)
          .to_timeout
          .then.to_return(status: 200, body: 'Success')

        Timecop.freeze do
          response = http_service.get(url)

          expect(response).to eq('Success')
          expect(WebMock).to have_requested(:get, url).twice
          expect(Rails.logger).to have_received(:error).once.with(/retrying/)
        end
      end
    end

    context 'when the request fails after max retries' do
      it 'logs an error and returns nil' do
        stub_request(:get, url).to_timeout

        Timecop.freeze do
          response = http_service.get(url)

          expect(response).to be_nil
          expect(WebMock).to have_requested(:get, url).times(HttpService::MAX_RETRIES)
          expect(Rails.logger).to have_received(:error).exactly(3).times.with(/retrying/)
          expect(Rails.logger).to have_received(:error).once.with(/Failed to fetch data after 3 attempts:/)
        end
      end
    end

    context 'when a non-retryable error occurs' do
      it 'logs the error and returns nil' do
        stub_request(:get, url).to_raise(RestClient::InternalServerError.new)

        response = http_service.get(url)

        expect(response).to be_nil
        expect(Rails.logger).to have_received(:error).with(/Internal Server Error/)
      end
    end

    context 'when an unexpected error occurs' do
      it 'logs the error and returns nil' do
        allow(RestClient).to receive(:get).and_raise(StandardError.new('Unexpected Error'))

        response = http_service.get(url)

        expect(response).to be_nil
        expect(Rails.logger).to have_received(:error).with(/Unexpected Error/)
      end
    end
  end
end
