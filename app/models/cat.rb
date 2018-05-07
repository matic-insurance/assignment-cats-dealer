class Cat
  attr_reader :shop, :location, :breed, :image, :price

  def initialize(opts={})
    @location = opts.fetch(:location)
    @shop = opts.fetch(:shop)
    @breed = opts.fetch(:breed)
    @image = opts.fetch(:image)
    @price = opts.fetch(:price)
  end
end