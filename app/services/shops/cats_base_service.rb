module Shops
  class CatsBaseService < ApplicationService
    CACHE_EXPIRES_IN = 24.hours

    def call
      fetch_from_cache || fetch_from_api
    end

    private

    def fetch_from_api
      @response ||= "Integration::Shops::#{shop_name}".constantize.send(:fetch)
      @collection = transform_response(@response)
      if @collection.present?
        Rails.cache.write(cache_key, @collection,
                          expires_in: CACHE_EXPIRES_IN)
      end
      @collection
    end

    def fetch_from_cache
      Rails.cache.read(cache_key)
    end

    def transform_response(response)
      "Shops::#{shop_name}Adapter".constantize.new(shop_name:).adapt(response)
    end

    def shop_name
      self.class::SHOP_NAME
    end

    def cache_key
      self.class::CACHE_KEY
    end
  end
end
