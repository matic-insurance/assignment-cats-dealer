# frozen_string_literal: true

module Cats
  module Providers
    class HappyCatsService < ::Cats::Providers::BaseService
      KEYS_MAPPING = {
        title: :cat_type,
        cost: :price,
        img: :image
      }.freeze

      VALUES_MAPPING = {
        price: ->(value) { value.to_i }
      }.freeze

      private

      def load_raw_data(data)
        ::Ox.load(data, mode: :hash_no_attrs).dig(:cats, :cat)
      end

      def url
        ::ENV.fetch('HAPPY_CATS_URL')
      end

      def name
        'Happy Cats'
      end
    end
  end
end
