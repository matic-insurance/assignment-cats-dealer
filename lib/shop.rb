class Shop
  def initialize(shop, filter_params)
    @shop = shop
    @filter_params = filter_params
  end

  def items
    items = response(client.get(shop.url))
    filter_items(items)
  end

  private

  attr_reader :shop, :filter_params

  def client
    shop.client
  end

  def response(response)
    shop.prepare_response(response)
  end

  def filter_items(items)
    items.select { |item| filter_location(item) && filter_name(item) }
  end

  def filter_location(item)
    filter_params[:user_location].to_s.downcase == item[:location].to_s.downcase
  end

  def filter_name(item)
    filter_params[:cats_type].to_s.downcase == item[:name].to_s.downcase
  end
end
