class ShopsConsolidatorService
  def initialize(filter_params)
    @filter_params = filter_params
  end

  def items
    items = []

    shops.each do |shop|
      items.push(*Shop.new(shop.new, filter_params).items)
    end

    items
  end

  private

  attr_reader :filter_params

  def shops
    [
      Shops::CatsUnlimited,
      Shops::HappyCats
    ]
  end
end
