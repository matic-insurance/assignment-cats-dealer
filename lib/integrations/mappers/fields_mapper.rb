class FieldsMapper
  def initialize(mapping)
    @mapping = mapping
  end

  def map_fields(product)
    product.map {
      | field, value| [@mapping[field] || field, value]
    }.to_h.with_indifferent_access
  end
end