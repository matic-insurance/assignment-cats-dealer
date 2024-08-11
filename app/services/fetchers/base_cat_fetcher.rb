# frozen_string_literal: true

module Fetchers
  # BaseCatFetcher is a base class for fetching cat data from different sources.
  # It provides common logic for iterating over parsed data and creating Cat objects.
  # Subclasses are expected to implement methods for parsing specific data formats
  # and extracting the necessary information from individual data entries.
  class BaseCatFetcher
    def initialize(http_service: ::HttpService.new)
      @http_service = http_service
    end

    def fetch
      response = http_service.get(self.class::URL)

      response ? parse(response) : []
    end

    private

    attr_reader :http_service

    def parse(_response)
      raise NotImplementedError, 'Subclasses must implement the `parse` method'
    end

    def extract_title(_cat)
      raise NotImplementedError, 'Subclasses must implement `extract_title`.'
    end

    def extract_cost(_cat)
      raise NotImplementedError, 'Subclasses must implement `extract_cost`.'
    end

    def extract_location(_cat)
      raise NotImplementedError, 'Subclasses must implement `extract_location`.'
    end

    def extract_image(_cat)
      raise NotImplementedError, 'Subclasses must implement `extract_image`.'
    end

    def parse_and_collect_cats(parsed_data)
      parsed_data.each_with_object([]) do |cat, cats|
        title = extract_title(cat)
        cost = extract_cost(cat)
        location = extract_location(cat)
        image = extract_image(cat)

        cats << ::Types::Cat.new(title, cost, location, image)
      rescue ::Errors::InvalidCatError => e
        Rails.logger.error("Invalid cat data: #{e.message}. Skipping this cat.")
      end
    end
  end
end
