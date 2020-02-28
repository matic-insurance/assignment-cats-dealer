# frozen_string_literal: true

module Cats
  module Dealer
    class Syncronizer
      SYNC_PERIOD = 5.minutes

      def self.sync_cats
        new.call
      end

      def call
        return unless need_sync?

        cats = fetched_cats.map(&method(:build_cat))

        Cat.import(cats,
                   on_duplicate_key_update: {
                     conflict_target: %i[breed location price image_url],
                     columns:         [:price]
                   })
      end

      private

      def need_sync?
        return true if Cat.count.zero?

        Cat.maximum(:updated_at) < (Time.current - SYNC_PERIOD)
      end

      def build_cat(cat)
        {
          breed:     cat.breed,
          price:     cat.price,
          location:  cat.location,
          image_url: cat.image_url
        }
      end

      def fetched_cats
        @fetched_cats ||= shops.map { |shop| shop.new.cats }.flatten
      end

      def shops
        ::Cats::Dealer.shops
      end
    end
  end
end
