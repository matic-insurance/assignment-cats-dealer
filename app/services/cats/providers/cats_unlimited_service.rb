# frozen_string_literal: true

module Cats
  module Providers
    class CatsUnlimitedService < ::Cats::Providers::BaseService
      KEYS_MAPPING = {
        name: :cat_type
      }.freeze

      private

      def load_raw_data(data)
        ::Oj.load(data).map(&:symbolize_keys)
      end

      def url
        ::ENV.fetch('CATS_UNLIMITED_URL')
      end

      def name
        'Cats Unlimited'
      end
    end
  end
end
