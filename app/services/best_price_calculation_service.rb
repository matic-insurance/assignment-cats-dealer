class BestPriceCalculationService
  def initialize(items)
    @items = items
  end

  def calculate
    items.min_by { |item| item[:price].to_f }
  end

  private

  attr_reader :items
end
