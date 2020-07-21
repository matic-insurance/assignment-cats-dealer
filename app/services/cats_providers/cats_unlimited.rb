module CatsProviders
  class CatsUnlimited < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
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
