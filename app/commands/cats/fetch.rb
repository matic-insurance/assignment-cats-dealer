module Cats
  ADAPTERS_INSTANCES = [
    Content::CatsUnlimited::Adapter,
    Content::HappyCats::Adapter
  ].freeze

  class Fetch
    def call
      fetcher = ::Content::Fetcher.new()
      ADAPTERS_INSTANCES.map do |adapter_instance|
        adapter_instance.new(fetcher: fetcher, creator_instance: Cat::Create).call
      end
    end
  end
end
