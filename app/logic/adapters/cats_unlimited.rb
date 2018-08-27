module Adapters
  class CatsUnlimited

    attr_reader :name, :price, :location, :image_url

    def self.instantiate(cats)
      cats.map { |cat| new(cat)}
    end

    def initialize(cat)
      @name = cat["name"]
      @price = cat["price"]
      @location = cat["location"]
      @image_url = cat["image"]
    end
  end
end
