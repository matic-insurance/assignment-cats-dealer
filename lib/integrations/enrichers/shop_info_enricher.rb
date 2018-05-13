class ShopInfoEnricher

  def initialize(name)
    @name = name
  end

  def enrich(product)
    product['shop'] = @name
    product
  end
end
