# frozen_string_literal: true

module Cats
  class HappyCatsAdapter
    API_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
    class ServerError < StandardError
    end

    def self.fetch_items
      api_response = Faraday.get(API_URL)

      return [] if api_response.status == 404

      raise ServerError if (500..599).include?(api_response.status)

      parsed = Hash.from_xml(api_response.body)['cats']

      return [] if parsed.blank?

      parsed['cat'].map do |item|
        {
          breed: item['title'],
          price: item['cost'].to_i,
          location: item['location'],
          image: item['img'],
        }
      end
    end
  end
end
