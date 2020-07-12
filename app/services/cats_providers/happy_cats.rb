module CatsProviders
  class HappyCats < Base
    def fetch_deals
      parse_options = {
        root_emelent: 'cats',
        child_element: 'cat'
      }

      @deals = DealParser.parse(
        RestClient.get(endpoint),
        DealParsers::XmlParser,
        parse_options
      )

      filter_deals
    end

    private

    def title_field_name
      'title'
    end

    def location_field_name
      'location'
    end

    def price_field_name
      'cost'
    end

    def image_field_name
      'img'
    end
  end
end
