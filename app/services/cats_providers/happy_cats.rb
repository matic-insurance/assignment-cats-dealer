module CatsProviders
  class HappyCats < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
    end

    def fetch_raw_deals
      parse_options = {
        root_emelent: 'cats',
        child_element: 'cat'
      }

      DealParser.parse(
        RestClient.get(endpoint),
        DealParsers::XmlParser,
        parse_options
      )
    end
  end
end
