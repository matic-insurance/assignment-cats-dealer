require 'restclient'
require 'json'
require 'active_support/core_ext/hash/conversions'

# Module which contains an base urls constants
module BaseAPIURL
  BASE_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/'

  def self.get_url(format)
    return BASE + 'json' if format == :json
    BASE_URL + 'xml'
  end
end

# Helper module for an HTTP calls
module Requests
  class BaseRequest
    # Base formats
    BASE_FORMATS = %i(xml json)

    class << self
      # NOTICE: this method we only using for XML response.
      # Excludes an hashes objects
      # From an array, and returns a new one
      def to_array(data)
        result = []
        data['cats']['cat'].each do |cat|
          result << cat
        end
        result
      end

      # Defines xml_response, and json_response methods
      BASE_FORMATS.each do |format|
        define_method :"#{format}_response" do
          if format == :json
            response = RestClient.get BaseAPIURL.get_url :json
            return JSON.parse response
          end
          response = RestClient.get BaseAPIURL.get_url :xml
          to_array(Hash.from_xml(response))
        end
      end
    end
  end
end
