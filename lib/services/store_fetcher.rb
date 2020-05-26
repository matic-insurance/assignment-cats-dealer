module Services
  class StoreFetcher
    attr_reader :store, :url, :type, :fetched_items

    def initialize(store)
      @store = store
      @url = store.api_endpoint
      @type = store.response_type
      @mapping = store.mapping
    end

    def call
      init_parser
      parse
      prepare_records
      deal_with_outdated_items!
      store_new_data
    end

    private

    def init_parser
      raise "#{@type} parser is not yet implemented" if !File.exists?(Rails.root.join("lib/parsers/#{type}.rb"))

      extend "::Parsers::#{@type.upcase}".constantize
    end

    def prepare_records
      normalize_fields!
      add_calculated_fields!
    end

    def normalize_fields!
      fetched_items.map do |item|
        item.symbolize_keys!
        mapping[:item_fields].each do |k, v|
          item[k] = item.delete(v)
        end
      end
    end

    # TODO: fix N+1 for city and breed select
    def add_calculated_fields!
      fetched_items.map do |item|
        item[:uuid] = Nanoid.generate
        item[:store] = store
        item[:price_currency] = store.currency || Store::DEFAULT_CURRENCY
        item[:city] = City.find_or_create_by(name: item[:city] )
        item[:breed] = Breed.find_or_create_by(name: item[:breed] )
      end
    end

    def deal_with_outdated_items!
      store.items.update_all(archived: true)
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
