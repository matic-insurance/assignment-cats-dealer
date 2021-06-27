# frozen_string_literal: true

module Cats
  module Providers
    class CatsUnlimitedService < ::Cats::Providers::BaseService
      MAPPINGS = {
        'name' => 'cat_type'
      }.freeze

      private

      def loader
        ::Oj
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
