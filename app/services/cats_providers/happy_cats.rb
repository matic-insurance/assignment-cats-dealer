module CatsProviders
  class HappyCats < Base
    def fetch_deals
      parse_options = {
        root_emelent: 'cats',
        child_element: 'cat'
      }

      deals = DealParser.parse(RestClient.get(endpoint), DealParsers::XmlParser, parse_options)
      filter_deals(deals)
    end

    private

    def filter_by_cat_type(deals, cat_type)
      deals.select { |deal| deal['title'] == cat_type }
    end
  end
end
