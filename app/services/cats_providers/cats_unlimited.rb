module CatsProviders
  class CatsUnlimited < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
    end

    def parser
      DealParsers::JsonParser
    end
  end
end
