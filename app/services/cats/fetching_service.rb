# frozen_string_literal: true

module Cats
  class FetchingService
    PROVIDERS = [
      ::Cats::Providers::CatsUnlimitedService
    ].freeze

    def self.call
      self::PROVIDERS.map do |provider|
        provider.instance.data
      end.flatten
    end
  end
end
