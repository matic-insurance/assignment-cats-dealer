module CatsProviders
  class CatsUnlimited < Base
    def fetch_deals
      deals = DealParser.parse(RestClient.get(endpoint), DealParsers::JsonParser)
      filter_deals(deals)
    end

    private

    def filter_by_cat_type(deals, cat_type)
      deals.select { |deal| deal['name'] == cat_type }
    end
  end
end
