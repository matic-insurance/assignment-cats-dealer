module Cats
  class Filter
    include Interactor

    def call
      @result = context.items

      @result = filter_by_breed if context.breed
      @result = filter_by_location if context.location

      context.items = @result.sort_by { |item| item[:price] }
    end

    private

    def filter_by_breed
      @result.select { |item| item[:breed].downcase == context.breed.downcase }
    end

    def filter_by_location
      @result.select { |item| item[:location].downcase == context.location.downcase }
    end
  end
end
