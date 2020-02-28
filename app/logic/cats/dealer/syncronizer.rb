
module Cats
  module Dealer
    class Syncronizer
      def self.sync_cats
        result = ::Cats::Dealer.shops.map do |shop|
          shop.new.cats
        end.flatten

        result.map do |res|
          ::Cat.find_or_create_by!(
            breed:     res.breed,
            price:     res.price,
            location:  res.location,
            image_url: res.image_url
          )
        end
      end

      def initialize
      end
    end
  end
end
