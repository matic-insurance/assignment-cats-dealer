require 'rails_helper'

describe Content::Fetcher do
  let(:url) { 'https://some_url.com/data' }
  let(:json_data) { { 'key1' => 'value', 'key2' => 'value2' } }

  subject { described_class.new() }

  describe "#call" do
    context "correct response" do
      context "type json" do
        it 'returns correct response data' do
          allow(RestClient).to receive(:get).and_return(double(code: 200, body: json_data.to_json))

          expect(subject.call(url: url, type: :json)).to eq(json_data)
        end
      end

      context "type xml" do
        it 'returns correct response data' do
          allow(RestClient).to receive(:get).and_return(double(code: 200, body: json_data.to_xml(root: :root)))

          expect(subject.call(url: url, type: :xml)).to eq({ 'root' => json_data })
        end
      end
    end

    context "incorrect response" do
      it 'raises exception' do
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse)

        expect { subject.call(url: url, type: :json) }.to raise_error(Content::Fetcher::FetcherError)
      end
    end

    it "returns nil when request has blank body" do
      allow(RestClient).to receive(:get).and_return(double(code: 200, body: nil))

      expect(subject.call(url: url, type: :json)).to eq(nil)
    end

    context "with wrong type argument" do
      it 'raises wrong type exception' do
        allow(RestClient).to receive(:get).and_return(double(code: 200, body: json_data.to_json))

        expect { subject.call(url: url, type: :bla_bla) }.to raise_error(Content::Fetcher::TypeError)
      end
    end

    context "with wrong body" do
      it 'raises wrong type exception' do
        allow(RestClient).to receive(:get).and_return(double(code: 200, body: json_data.to_json))

        expect { subject.call(url: url, type: :xml) }.to raise_error(Content::Fetcher::TypeError)

        allow(RestClient).to receive(:get).and_return(double(code: 200, body: json_data.to_xml(root: :root)))

        expect { subject.call(url: url, type: :json) }.to raise_error(Content::Fetcher::TypeError)
      end
    end
  end
end
