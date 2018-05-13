class ProductAggregationService
  def initialize(products)
    @products = products
  end

  def allowed_query_params
    [location: [], shop: []]
  end

  def filter_options
    {
      locations: locations.sort,
      shops: shops.sort
    }
  end

  def locations
    @locations ||= @products.collect(&:location).compact.uniq
  end

  def shops
    @shops ||= @products.collect(&:shop).compact.uniq
  end

  def find_where(query = {}, strict: false)
    query = strict ? query : filter_empty_params(query)
    @products.select do |product|
      query.map do |field, value|
        value.include?(product.send(field.to_sym))
      end .all?
    end
  end

  private

  def filter_empty_params(query)
    query.reject { |_, value| value.blank? }
  end
end
