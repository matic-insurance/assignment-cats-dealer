# frozen_string_literal: true

module Parser
  class JsonParser < BaseParser
    RELATED_KEYS = {
      'name' => BaseParser::CAT_TYPE_KEY,
      'price' => BaseParser::PRICE_KEY
    }
    def self.parse_body(parsed_data)
      JSON.parse(parsed_data)
    end

    def self.solidify_keys(parsed_data)
      case parsed_data
      when Array
        parsed_data.map { |item| solidify_keys(item) }
      when Hash
        parsed_data.each_with_object({}) do |(key, value), result|
          if RELATED_KEYS.key?(key)
            result[RELATED_KEYS[key]] = value
          else
            result[key] = solidify_keys(value)
          end
        end
      else
        parsed_data
      end
    end
  end
end
