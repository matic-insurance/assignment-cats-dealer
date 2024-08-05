# frozen_string_literal: true

module Parser
  class BaseParser
    CAT_TYPE_KEY = 'cat_type'
    PRICE_KEY = 'price'
    LOCATION_KEY = 'location'
    IMAGE_KEY = 'image'

    class << self
      def parse(data)
        parsed_data = parse_body(data)
        consolidate_keys(parsed_data)
      end

      def parse_body(_data)
        raise NotImplementedError, 'You must implement the parse_body method in child class'
      end

      def consolidate_keys(_object)
        raise NotImplementedError, 'You must implement the consolidate_keys! method in child class'
      end
    end
  end
end
