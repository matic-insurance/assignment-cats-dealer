# frozen_string_literal: true

require 'nokogiri'

module Fetchers
  # HappyCatsFetcher is responsible for fetching and parsing cat data
  # from the "Happy Cats" API, which returns data in XML format.
  #
  # This class inherits common functionality from BaseCatFetcher, specifically
  # the logic to iterate over parsed data and create Cat objects.
  #
  # The HappyCatsFetcher extracts specific fields (title, cost, location,
  # image) from the XML response, converting them into structured Cat objects.
  #
  # In case of XML parsing errors or invalid cat data, appropriate logging
  # is performed, and the faulty data is skipped.
  class HappyCatsFetcher < BaseCatFetcher
    URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'

    private

    def parse(response)
      doc = Nokogiri::XML(response)
      parse_and_collect_cats(doc.xpath('//cat'))
    rescue Nokogiri::XML::SyntaxError => e
      Rails.logger.error("Failed to parse XML response: #{e.message}")
      []
    end

    def extract_title(cat)
      cat.at_xpath('title')&.text
    end

    def extract_cost(cat)
      cat.at_xpath('cost')&.text.to_f
    end

    def extract_location(cat)
      cat.at_xpath('location')&.text
    end

    def extract_image(cat)
      cat.at_xpath('img')&.text
    end
  end
end
