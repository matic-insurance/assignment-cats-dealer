module Cats
  class Fetch
    include Interactor

    PROVIDERS = [
      ::Cats::Providers::CatsUnlimitedService
    ].freeze

    def call
      context.list = PROVIDERS.map { |provider| provider.instance.data }.flatten
    rescue ProviderUnavailableError => e
      context.fail!(error: e.message)
    end
  end
end
