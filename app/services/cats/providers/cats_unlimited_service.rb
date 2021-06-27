# frozen_string_literal: true

module Cats
  module Providers
    class CatsUnlimitedService < ::Cats::Providers::BaseService
      private

      def loader
        ::Oj
      end

      def url
        ::ENV.fetch('CATS_UNLIMITED_URL')
      end
    end
  end
end
