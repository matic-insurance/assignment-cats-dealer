# frozen_string_literal: true

module Cats
  class Fetch
    include Interactor

    PROVIDERS = [
      ::Cats::Providers::CatsUnlimitedService,
      ::Cats::Providers::HappyCatsService
    ].freeze
    CACHE_TIME = 12.hours

    delegate :filters, to: :context

    def call
      context.list = result
    rescue ProviderUnavailableError => e
      context.fail!(error: e.message)
    end

    private

    def result
      all = ::Rails.cache.fetch('cats/fetch', expires_in: CACHE_TIME) do
        PROVIDERS.map { |provider| provider.instance.data }.flatten
      end
      filter_cats(all)
    end

    def filter_cats(list)
      return list if filters.blank?

      list.select { |cat| cat.values_at(*filters.keys) == filters.values }
    end
  end
end
