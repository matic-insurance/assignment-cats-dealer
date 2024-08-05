module Parser
  class BaseParser
    CAT_TYPE_KEY = 'cat_type'.freeze
    PRICE_KEY = 'price'.freeze
    LOCATION_KEY = 'location'.freeze
    IMAGE_KEY = 'image'.freeze

    def self.parse(data)
      parsed_data = parse_body(data)
      solidify_keys(parsed_data)
    end

    def self.parse_body(_data)
      raise NotImplementedError, 'You must implement the parse_body method in child class'
    end

    def self.solidify_keys(_object)
      raise NotImplementedError, 'You must implement the solidify_keys! method in child class'
    end
  end
end
