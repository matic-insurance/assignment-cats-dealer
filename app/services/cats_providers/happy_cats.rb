module CatsProviders
  class HappyCats < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
    end
  end
end
