class Cat < ApplicationRecord
  class Create
    attr_reader :name, :price, :location, :image

    def initialize(args)
      @name = args.fetch(:name)
      @price = args.fetch(:price)
      @location = args.fetch(:location)
      @image = args.fetch(:image)
    end

    def call
      Cat.find_or_create_by(
        name: name,
        price: price,
        location: location,
        image: image_exists? ? image : nil
      )
    end

    def image_exists?
      RestClient.head image
      true
    rescue RestClient::ExceptionWithResponse => e
      false
    end
  end
end
