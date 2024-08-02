module Integration
  module Shops
    class BaseClient
      def initialize
        @connection = Faraday.new do |faraday|
          faraday.adapter :async_http
        end
      end

      def self.fetch(...)
        new(...).fetch_records
      end

      def fetch_records
        make_request(self.class::SHOP_URL)
      end

      def make_request(url)
        response = @connection.get(url)
        parse_response(response)
      rescue Faraday::Error => e
        Rails.logger.error "Error fetching data from #{url}: #{e.message}"

        []
      end

      def parse_response(response)
        raise NotImplementedError, "This #{self.class} cannot respond to: #{__method__}"
      end
    end
  end
end
