module Cats
  class Filter
    def initialize(breed: nil, location: nil)
      @breed = breed
      @location = location
      @result = Cats::Fetch.new.call
    end

    def call
      @result = filter_by_breed if @breed
      @result = filter_by_location if @location

      @result
    end

    private

    def filter_by_breed
      @result.select { |item| item[:breed].downcase == @breed.downcase }
    end

    def filter_by_location
      @result.select { |item| item[:location].downcase == @location.downcase }
    end
  end
end
