class FieldsMapper
  def initialize(mapping)
    @mapping = mapping
  end

  def map_fields(product)
    product.map do |field, value|
      [@mapping[field] || field, value]
    end.to_h.with_indifferent_access
  end
end
