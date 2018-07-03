require 'restclient'
require 'json'
require 'active_support/core_ext/hash/conversions'

# Module which contains an base urls constants
module BaseAPIURL
  JSON_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze
  XML_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze
end

# Helper module for an HTTP calls
module HTTPRequestService
  # Base HTTP request class
  # for an future classes
  class BaseRequest
    attr_reader :url

    def initialize(url)
      @url = url
    end

    # Returns an response object
    def response
      RestClient.get @url
    end

    # Parses an response from :json
    def from_json
      JSON.parse response.body
    end

    # Parses an response from :xml
    def from_xml
      Hash.from_xml response.body
    end
  end
end
