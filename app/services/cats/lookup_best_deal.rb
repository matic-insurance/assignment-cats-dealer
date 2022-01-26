module Cats
  class LookupBestDeal
    def initialize(sources: [])
      @sources = sources
    end

    def call(location: nil, cat_type: nil)
      cats = load_resources
      cats = apply_location_filter(cats, location)
      cats = apply_cat_type_filter(cats, cat_type)

      find_cheapest(cats)
    end

    private

      attr_reader :sources

      def apply_location_filter(cats, location)
        apply_filter(cats, name: :location, value: location)
      end

      def apply_cat_type_filter(cats, cat_type)
        apply_filter(cats, name: :name, value: cat_type)
      end

      def apply_filter(cats, name:, value:)
        return cats if value.nil?

        cats.select { |cat| cat.send(name).downcase == value.downcase }
      end

      def find_cheapest(cats)
        cats.min_by(&:price)
      end

      def load_resources
        sources.map(&:call).flatten
      end
  end
end
