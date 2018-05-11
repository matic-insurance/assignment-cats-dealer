class ProductAggregationService

  def initialize(products)
    @products = products
  end

  def locations
    @locations ||= @products.collect {|product| product.location}.compact.uniq
  end

  def breeds
    @breeds ||= @products.collect {|product| product.breed}.compact.uniq
  end

  def find_where(opts={})
    opts = opts.select {|key, value| !value.blank? }
    @products.select{
      |product| opts.map {
        |field, value| product.send(field.to_sym) == value }.all?
    }
  end
end