module CatsProviders
  class CatsUnlimited < Base
    def fetch_deals
      deals = DealParser.parse(RestClient.get(endpoint), DealParsers::JsonParser)
      filter_deals(deals)
    end

    private

    def title_field_name
      'name'
    end
  end
end
