class CatsAggregationService < ProductAggregationService

  def allowed_query_params
    super + [:breed => []]
  end

  def filter_options
    super.merge({
      breeds: breeds.sort
    })
  end

  def breeds
    @breeds ||= @products.collect {|product| product.breed}.compact.uniq
  end
end