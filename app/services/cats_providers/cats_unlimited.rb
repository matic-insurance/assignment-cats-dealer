module CatsProviders
  class CatsUnlimited < Base
    def fetch_deals
      @deals = DealParser.parse(RestClient.get(endpoint), DealParsers::JsonParser)
      filter_deals
    end

    private

    def title_field_name
      'name'
    end

    def location_field_name
      'location'
    end

    def price_field_name
      'price'
    end

    def image_field_name
      'image'
    end
  end
end
