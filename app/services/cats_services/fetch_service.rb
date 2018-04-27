require 'providers/adapters/best_pussycat'
require 'providers/adapters/kitty_shop'

module CatsServices
  class FetchService
    class << self
      UNIFIED_PROVIDERS = [
        Providers::Adapters::KittyShop,
        Providers::Adapters::BestPussycat
      ].freeze

      def all
        basic_cats = concurrent_fetch(UNIFIED_PROVIDERS).flatten
        wrap(basic_cats)
      end

      private

      def wrap(basic_cats)
        basic_cats.map { |c| Cat.new(c.as_json) }
      end

      def concurrent_fetch(providers)
        promises = providers.map do |provider|
          Concurrent::Promise.new { provider.new.fetch_all }
        end

        Concurrent::Promise.zip(*promises).value!
      end
    end
  end
end
