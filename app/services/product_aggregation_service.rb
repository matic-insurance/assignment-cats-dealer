class ProductAggregationService
  attr_accessor :products

  def initialize(products)
    @products = products
  end

  def allowed_query_params
    [{location: []}, {shop: []}]
  end

  def filter_options
    {
      locations: locations.sort,
      shops: shops.sort
    }
  end

  def locations
    @locations ||= products.collect(&:location).compact.uniq
  end

  def shops
    @shops ||= products.collect(&:shop).compact.uniq
  end

  def find(query_params = {})
    filter_products(query_params)
  end

  def count(query_params = {})
    filter_products(query_params).size
  end

  private

  def filter_products(query_params)
    products.select do |product|
      query_params.map do |field, value|
        value.include?(product.send(field.to_sym))
      end.all?
    end
  end
end
