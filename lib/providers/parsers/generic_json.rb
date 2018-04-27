module Providers
  module Parsers
    class GenericJSON
      def parse(response_body)
        JSON.parse(response_body, symbolize_names: true)
      rescue JSON::ParserError
        empty_result
      end

      private

      def empty_result
        []
      end
    end
  end
end
