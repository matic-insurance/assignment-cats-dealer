# frozen_string_literal: true

module Cats
  class CatsUnlimitedAdapter
    API_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
    class ServerError < StandardError
    end

    def self.fetch_items
      api_response = Faraday.get(API_URL)

      return [] if api_response.status == 404

      raise ServerError if (500..599).include?(api_response.status)

      parsed = JSON.parse(api_response.body)

      parsed.map do |item|
        {
          breed: item['name'],
          price: item['price'].to_i,
          location: item['location'],
          image: item['image'],
        }
      end
    end
  end
end
