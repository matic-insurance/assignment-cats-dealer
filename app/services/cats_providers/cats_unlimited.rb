module CatsProviders
  class CatsUnlimited
    def self.get_deals(search_request)
      deals = DealParser.parse(
                RestClient.get(CatsDealerConfig.provider_endpoints[self.name.split('::').last.underscore.to_sym]), 
                DealParsers::JsonParser
              )

      deals = filter_by_location(deals, search_request.location)
      filter_by_cat_type(deals, search_request.cat_type)
    end

    def self.filter_by_location(deals, location)
      deals.select { |deal| deal['location'] == location }
    end

    def self.filter_by_cat_type(deals, cat_type)
      deals.select { |deal| deal['name'] == cat_type }
    end
  end
end
