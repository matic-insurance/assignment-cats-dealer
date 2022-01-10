module CatsDealers
  module Clients
    class CatsUnlimited < Base
      private

      def parser
        CatsDealers::Parsers::Json.new
      end

      def url
        'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze
      end
    end
  end
end
