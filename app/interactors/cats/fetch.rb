module Cats
  class Fetch
    include Interactor

    PROVIDERS = [
      ::Cats::Providers::CatsUnlimitedService,
      ::Cats::Providers::HappyCatsService
    ].freeze

    delegate :filters, to: :context

    def call
      all = PROVIDERS.map { |provider| provider.instance.data }.flatten
      context.list = filter_cats(all)
    rescue ProviderUnavailableError => e
      context.fail!(error: e.message)
    end

    private

    def filter_cats(list)
      return list if filters.blank?

      list.select { |cat| cat.values_at(*filters.keys) == filters.values }
    end
  end
end
