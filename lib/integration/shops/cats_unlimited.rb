module Integration
  module Shops
    class CatsUnlimited < BaseClient
      SHOP_URL = ENV.fetch('CATS_UNLIMITED_URL', 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json').freeze

      def parse_response(response)
        Oj.load(response.body, symbol_keys: true)
      end
    end
  end
end
