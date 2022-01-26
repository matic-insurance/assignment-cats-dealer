require_relative '../clients/xml'

module Cats
  module Shops
    class HappyCats
      CACHE_TTL = 1.day

      def self.build_record(record)
        ::Cats::Record.new(
          name: record[:title],
          price: record[:cost],
          location: record[:location],
          image: record[:img]
        )
      end

      def initialize(client: ::Cats::Clients::Xml.new, url: ENV['HAPPY_CATS_API_URL'])
        @client = client
        @url = url
      end

      def call
        Rails.cache.fetch('sources:happy-cats:result', expires_in: CACHE_TTL) do
          records = fetch_records(client.call(url))
          records.map { |record| self.class.build_record(record) }
        end
      end

      private

        attr_reader :client, :url

        def fetch_records(response)
          response.dig(:cats, :cat) || []
        end
    end
  end
end
