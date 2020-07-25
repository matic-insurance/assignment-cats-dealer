module Store
  class ExecutorService
    extend Callable

    def initialize(_)
      @providers_configuration = Rails.configuration.settings.fetch(:providers)
    end

    def perform
      fetch_providers_data
    end

    private

    attr_reader :providers_configuration

    def fetch_providers_data
      threads = []

      active_providers.each do |provider_name, configuration|
        provider = "Store::Providers::#{provider_name.to_s.classify}".constantize

        threads << Thread.new { provider.call(configuration: configuration) }
      end

      threads.map(&:value).flatten
    end

    def active_providers
      providers_configuration.select { |_, value| value[:enabled] }
    end
  end
end
