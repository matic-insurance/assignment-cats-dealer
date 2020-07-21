module CatsProviders
  class HappyCats < Base
    def fetch_deals
      @deals = Provider.provider_deals(self.class.name.demodulize)
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
