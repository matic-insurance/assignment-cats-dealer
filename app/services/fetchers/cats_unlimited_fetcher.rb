# frozen_string_literal: true

require 'json'

module Fetchers
  # CatsUnlimitedFetcher is responsible for fetching and parsing cat data
  # from the "Cats Unlimited" API, which returns data in JSON format.
  #
  # This class inherits common functionality from BaseCatFetcher, specifically
  # the logic to iterate over parsed data and create Cat objects.
  #
  # The CatsUnlimitedFetcher extracts specific fields (name, price, location,
  # image) from the JSON response, converting them into structured Cat objects.
  #
  # In case of JSON parsing errors or invalid cat data, appropriate logging
  # is performed, and the faulty data is skipped.
  class CatsUnlimitedFetcher < BaseCatFetcher
    URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'

    private

    def parse(response)
      parsed_data = JSON.parse(response)
      parse_and_collect_cats(parsed_data)
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse JSON response: #{e.message}")
      []
    end

    def extract_title(cat)
      cat['name']
    end

    def extract_cost(cat)
      cat['price'].to_f
    end

    def extract_location(cat)
      cat['location']
    end

    def extract_image(cat)
      cat['image']
    end
  end
end
