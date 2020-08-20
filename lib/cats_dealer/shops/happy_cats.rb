module CatsDealer
  module Shops
    class HappyCats < BaseShop
      def url
        ENV['HAPPY_CATS_URL']
      end

      def parse(data)
        Hash.from_xml(data)&.deep_symbolize_keys&.dig(:cats, :cat)
      end

      def serialize(data)
        {
          breed: data[:title],
          location: data[:location],
          price: data[:cost]&.to_f,
          image: data[:img]
        }
      end
    end
  end
end
