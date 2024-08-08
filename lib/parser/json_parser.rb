# frozen_string_literal: true

module Parser
  class JsonParser < BaseParser
    RELATED_KEYS = {
      'name' => BaseParser::CAT_TYPE_KEY,
      'price' => BaseParser::PRICE_KEY
    }.freeze

    class << self
      def parse_body(parsed_data)
        JSON.parse(parsed_data)
      end

      def consolidate_keys(parsed_data)
        case parsed_data
        when Array
          consolidate_keys_for_array(parsed_data)
        when Hash
          consolidate_keys_for_hash(parsed_data)
        else
          parsed_data
        end
      end

      def consolidate_keys_for_array(array_data)
        array_data.map { |item| consolidate_keys(item) }
      end

      def consolidate_keys_for_hash(hash_data)
        hash_data.each_with_object({}) do |(key, value), result|
          if RELATED_KEYS.key?(key)
            result[RELATED_KEYS[key]] = value
          else
            result[key] = consolidate_keys(value)
          end
        end
      end
    end
  end
end
