module CatsProviders
  class HappyCats < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
    end

    def parser
      DealParsers::XmlParser
    end

    def parse_options
      {
        root_emelent: 'cats',
        child_element: 'cat'
      }
    end
  end
end
