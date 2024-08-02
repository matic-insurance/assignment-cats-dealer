module Integration
  module Shops
    class CatsHappy < BaseClient
      SHOP_URL = ENV.fetch('CATS_HAPPY_URL', 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml').freeze

      def parse_response(response)
        Ox.load(response.body, mode: :hash_no_attrs).dig(:cats, :cat)
      end
    end
  end
end
