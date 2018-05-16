class Cat
  attr_reader :shop, :location, :breed, :image

  def initialize(opts = {})
    @location = opts.fetch(:location, nil)
    @shop     = opts.fetch(:shop, nil)
    @breed    = opts.fetch(:breed, nil)
    @image    = opts.fetch(:image, nil)
    @price    = opts.fetch(:price, nil)
  end

  def price
    return if @price.nil?
    price = @price.to_f
    price.zero? ? 0 : price
  end
end
