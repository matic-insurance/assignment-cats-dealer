class ProductAggregationService

  def initialize(products)
    @products = products
  end

  def allowed_query_params
    [:location => [], :shop => []]
  end

  def filter_options
    {
      locations: locations.sort,
      shops: shops.sort
    }
  end

  def locations
    @locations ||= @products.collect {|product| product.location}.compact.uniq
  end

  def shops
    @shops ||= @products.collect {|product| product.shop}.compact.uniq
  end

  def find_where(query = {}, strict: false)
    query = strict ? query : filter_empty_params(query)
    @products.select {
      |product| query.map {
        |field, value| value.include?(product.send(field.to_sym))}.all?
    }
  end

  private

  def filter_empty_params(query)
    query.select {|_, value| !value.blank?}
  end

end