class Filters
  
  attr_accessor :deals, :search_request

  def initialize(deals, search_request=nil)
    @deals = deals
    @search_request = search_request
  end

  def execute
    filter_by_location!
    filter_by_breed!
    filter_by_lowest_price!
  end

  private

  def filter_by_location!
    deals.select! { |deal| deal[location_field_name] == search_request.user_location }
  end

  def filter_by_breed!
    deals.select! { |deal| deal[title_field_name] == search_request.breed }
  end

  def filter_by_lowest_price!
    Array.wrap(deals.min_by { |deal| deal[price_field_name].to_i })
  end

  def location_field_name
    :location
  end

  def title_field_name
    :breed
  end

  def price_field_name
    :price
  end
end