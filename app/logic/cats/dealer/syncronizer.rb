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

        ApplicationRecord.transaction do
          Cat.destroy_all
          Cat.import(cats)
        end
      end

      private

      def need_sync?
        return true if Cat.count.zero?

        Cat.maximum(:updated_at) < SYNC_PERIOD.ago
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
        shops.map { |shop| shop.new.cats }.flatten.compact
      end

      def shops
        @shops ||= ::Cats::Dealer.shops
      end
    end
  end
end
