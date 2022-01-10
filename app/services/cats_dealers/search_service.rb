module CatsDealers
  class SearchService
    class << self
      def call(collection = [], input_parameters = {})
        parameters = input_parameters.slice(:breed, :location, :price).reject { |_, value| value.blank? }
        filtered_collection = process(collection, parameters)
        filtered_collection.sort_by { |hash| hash[:price].to_d }
      end

      private

      # rubocop:disable all
      def process(collection, parameters)
        case parameters
        in { location: location, breed: breed, price: price }
          collection.select { |hash| hash[:location] == location && hash[:breed] == breed && hash[:price] == price }
        in { location: location, breed: breed }
          collection.select { |hash| hash[:location] == location && hash[:breed] == breed }
        in { location: location, price: price }
          collection.select { |hash| hash[:location] == location && hash[:price] == price }
        in { breed: breed, price: price }
          collection.select { |hash| hash[:breed] == breed && hash[:price] == price }
        in { location: location }
          collection.select { |hash| hash[:location] == location }
        in { breed: breed }
          collection.select { |hash| hash[:breed] == breed }
        in { price: price }
          collection.select { |hash| hash[:price] == price }
        else
          []
        end
      end
      # rubocop:enable all
    end
  end
end
