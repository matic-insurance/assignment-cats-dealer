require "rails_helper"

RSpec.describe Cats::CatsUnlimitedAdapter do
  describe ".fetch_items" do
    it "calls Faraday" do
      stub_faraday

      described_class.fetch_items

      expect(Faraday).
        to have_received(:get).
        with(Cats::CatsUnlimitedAdapter::API_URL)
    end

    it "parses response" do
      api_response = [
        {
          name: "Grumpy",
          price: "123",
          location: "Kyiv",
          image: "link.to/image.jpg"
        }
      ].to_json

      expected_result = [
        {
          breed: "Grumpy",
          price: 123,
          location: "Kyiv",
          image: "link.to/image.jpg"
        }
      ]

      stub_faraday(body: api_response)

      result = described_class.fetch_items

      expect(result).to eq(expected_result)
    end

    context "if server returns 404" do
      it "returns empty array" do
        stub_faraday(body: "Not found", status: 404)

        result = described_class.fetch_items

        expect(result).to eq([])
      end
    end

    context "if servers returns status 5xx" do
      it "raises Cats::CatsUnlimitedAdapter::ServerError" do

        stub_faraday(body: "Something went wrong", status: 500)

        expect { described_class.fetch_items }.to raise_error(Cats::CatsUnlimitedAdapter::ServerError)
      end
    end
  end

  def stub_faraday(body: '[]', status: 200)
    faraday_response = instance_double(
      "Faraday::Response",
      status: status,
      body: body,
    )

    allow(Faraday).
      to receive(:get).
      with(Cats::CatsUnlimitedAdapter::API_URL).
      and_return(faraday_response)
  end
end
