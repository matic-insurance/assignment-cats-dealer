module CatsProviders
  class Base
    attr_reader :search_request

    def initialize(search_request)
      @search_request = search_request
    end

    private

    def endpoint
      CatsDealerConfig.provider_endpoints[self.class.name.split('::').last.underscore.to_sym]
    end

    def filter_deals(deals)
      deals = filter_by_location(deals, search_request.user_location)
      filter_by_cat_type(deals, search_request.cat_type)
    end

    def filter_by_location(deals, location)
      deals.select { |deal| deal[location_field_name] == location }
    end

    def filter_by_cat_type(deals, cat_type)
      deals.select { |deal| deal[title_field_name] == cat_type }
    end
  end
end
