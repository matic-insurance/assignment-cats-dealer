module Services
  class StoreFetcher
    def initialize(store)
      @store = store
      @url = store.api_endpoint
      @type = store.response_type
      @mapping = store.mapping
    end

    def call
      call_api

      return if response.blank?

      init_parser
      parse
      prepare_records
      deal_with_outdated_items
      store_new_data
    end

    private

    attr_reader :store, :url, :type, :fetched_items, :response

    def init_parser
      raise "#{@type} parser is not yet implemented" unless File.exist?(Rails.root.join("lib/parsers/#{type}.rb"))

      extend "::Parsers::#{@type.upcase}".constantize
    end

    def call_api
      @response = RestClient.get(@url)
    end

    def prepare_records
      normalize_fields
      add_calculated_fields
    end

    def normalize_fields
      fetched_items.map do |item|
        item.symbolize_keys!
        mapping[:item_fields].each do |k, v|
          item[k] = item.delete(v)
        end
      end
    end

    # TODO: fix N+1 for city and breed select
    def add_calculated_fields
      fetched_items.map do |item|
        item[:uuid] = Nanoid.generate
        item[:store] = store
        item[:price_currency] = store.currency || Store::DEFAULT_CURRENCY
        item[:city] = City.find_or_create_by(name: item[:city])
        item[:breed] = Breed.find_or_create_by(name: item[:breed])
      end
    end

    def deal_with_outdated_items
      # we could store last update timestamp and use it as a line to filter if DB gets to big for updatess like that
      store.items.update_all(active: false)
    end

    def store_new_data
      records = []
      fetched_items.each do |item|
        record = Item.new(item)
        records << record if record.valid?
      end

      Item.import(records)
    end

    def mapping
      return @mapping if @mapping.present?

      "Store::DEFAULT_#{@type.upcase}_MAPPING".constantize
    end
  end
end
