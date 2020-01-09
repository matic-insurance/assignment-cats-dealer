require 'json'
module Parsing
  module Formats
    module Json

      def parse
        JSON.parse(RestClient.get(products_url))
      end

    end
  end
end
