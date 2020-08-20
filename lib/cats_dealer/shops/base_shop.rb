module CatsDealer
  module Shops
    class BaseShop
      STATUS_OK = 200

      def get_pretty_cats
        raw_data = load_raw_data
        parsed_data = parse(raw_data)
        serialize_data(parsed_data)
      end

      private

      def load_raw_data
        response = RestClient.get(url)
        if response.code == STATUS_OK
          response.body
        else
          log("Response error: #{response.body}")
          []
        end
      end

      def serialize_data(data)
        data.map { |item| serialize(item) }
      end

      def get_url
        raise NotImplementedError
      end

      def parse(data)
        raise NotImplementedError
      end

      def serialize(data)
        raise NotImplementedError
      end
    end
  end
end
