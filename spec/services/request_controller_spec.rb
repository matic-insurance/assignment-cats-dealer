require 'rails_helper'
require_relative '../../app/services/requests'

describe HTTPRequestService::BaseRequest do
  before(:each) do
    @xml_url = BaseAPIURL::XML_URL
    @json_url = BaseAPIURL::JSON_URL
    @json_client = HTTPRequestService::BaseRequest.new @json_url
    @xml_client = HTTPRequestService::BaseRequest.new @xml_url
  end

  describe "Raise error" do
    context "URL argument wasn't provided" do
      it "it raises ArgumentError" do
        expect { HTTPRequestService::BaseRequest.new }.to raise_error(ArgumentError)
      end
    end

    describe "Initialize BaseRequest object" do
      context "checks if a URL is correct" do
        it "it returns correct URL" do
          expect(@json_client.url).to eql(@json_url)
        end
      end
    end


    describe "Make BaseRequest calls" do
      context "checks if an call is correct" do
        it "it returns HTTP status 200" do
          expect(@json_client.response.code).to eql(200)
        end

        it "it makes an array from :json" do
          expect(@json_client.from_json).to be_a(Array)
        end

        it "it makes a hash from :xml" do
          expect(@xml_client.from_xml).to be_a(Hash)
        end
      end
    end
  end
end