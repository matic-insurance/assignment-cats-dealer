module Cats
  class Record
    attr_reader :name, :price, :location, :image

    def initialize(name:, price:, location:, image: nil)
      @name = name
      @price = price.to_i
      @location = location
      @image = image
    end
  end
end
