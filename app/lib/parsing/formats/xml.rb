require 'json'

module Parsing
  module Formats
    module Xml

      def parse
        Hash.from_xml(RestClient.get(products_url))
      end

      def root
        # after parsing xml we need to dive into 2 levels to get array of items
        @items[product_plural][@shop.product]
      end

    end
  end
end