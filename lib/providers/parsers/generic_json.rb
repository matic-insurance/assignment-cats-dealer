require 'logger'

module Providers
  module Parsers
    class GenericJSON
      def parse(response_body)
        JSON.parse(response_body, symbolize_names: true)
      rescue JSON::ParserError => error
        Rails.logger.error("[Parsers::GenericJSON] Unable to parse response, #{error}")
        empty_result
      end

      private

      def empty_result
        []
      end
    end
  end
end
