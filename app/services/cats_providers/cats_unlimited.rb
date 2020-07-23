module CatsProviders
  class CatsUnlimited < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
    end

    def fetch_raw_deals
      DealParser.parse(RestClient.get(endpoint), DealParsers::JsonParser)
    end
  end
end
