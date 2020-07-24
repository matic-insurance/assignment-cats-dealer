require 'field_mappings'

module CatsProviders
  class Base
    attr_reader :search_request, :deals

    include CatsProviders::DealerConfigs

    def initialize(search_request = nil)
      @search_request = search_request
      @deals = []
    end

    def fetch_deals
      raise NoMethodError, "#{__method__} method should be implemented"
    end

    def parse_options
      {}
    end
  end
end
