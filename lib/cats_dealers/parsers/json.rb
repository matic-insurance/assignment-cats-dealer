module CatsDealers
  module Parsers
    class Json
      def parse(response_body)
        JSON.parse(response_body, symbolize_names: true)
      rescue JSON::ParserError
        []
      end
    end
  end
end
