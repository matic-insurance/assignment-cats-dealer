module Adapters
  class HappyCats

    attr_reader :name, :price, :location, :image_url

    def self.instantiate(cats)
      cats.map { |cat| new(cat)}
    end

    def initialize(cat)
      @name = cat["title"]
      @price = cat["cost"]
      @location = cat["location"]
      @image_url = cat["img"]
    end
  end
end
