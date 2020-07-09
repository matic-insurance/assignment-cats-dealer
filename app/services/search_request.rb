class SearchRequest
  attr_reader :cat_type, :location

  def initialize(params)
    @cat_type = params[:cat_type]
    @location = params[:user_location]
  end

  def self.search(params)
    CatsDealer.get_deals(SearchRequest.new(params))
  end
end
