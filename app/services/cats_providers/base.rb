require 'field_mappings'

module CatsProviders
  class Base
    attr_reader :search_request, :deals

    extend FieldMapings

    def initialize(search_request)
      @search_request = search_request
      @deals = []
    end

    private

    def endpoint
      CatsDealerConfig.provider_endpoints[self.class.name.split('::').last.underscore.to_sym]
    end

    def filter_deals
      filter_by_location!
      filter_by_breed!
      filter_by_lowest_price!
      apply_field_mappings!
    end

    def filter_by_location!
      deals.select! { |deal| deal[location_field_name] == search_request.user_location }
    end

    def filter_by_breed!
      deals.select! { |deal| deal[title_field_name] == search_request.cat_type }
    end

    def filter_by_lowest_price!
      Array.wrap(deals.min_by { |deal| deal[price_field_name].to_i })
    end

    def apply_field_mappings!
      deals.each_with_object([]) do |deal, deals|
        deals << build_deal(deal)
        deals
      end
    end

    def build_deal(current_deal)
      current_deal.keys.each_with_object({}) do |deal_key, deal|
        deal[FieldMapings.field_name_mappings[deal_key.to_sym]] = current_deal[deal_key]
        deal
      end
    end
  end
end
