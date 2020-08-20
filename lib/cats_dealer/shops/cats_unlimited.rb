module CatsDealer
  module Shops
    class CatsUnlimited < BaseShop
      def url
        ENV['CATS_UNLIMITED_URL']
      end

      def parse(data)
        JSON.parse(data, symbolize_names: true)
      end

      def serialize(data)
        {
          breed: data[:name],
          location: data[:location],
          price: data[:price]&.to_f,
          image: data[:image]
        }
      end
    end
  end
end
