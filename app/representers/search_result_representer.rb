class SearchResultRepresenter
  def initialize(search_result)
    @search_result = search_result
  end

  def cats_list
    @search_result.items
  end

  def best_price
    BestPriceCalculationService.new(search_result.items).calculate
  end

  private

  attr_reader :search_result
end
