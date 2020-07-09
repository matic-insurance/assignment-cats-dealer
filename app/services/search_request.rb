class SearchRequest
  attr_reader :cat_type, :location

  def initialize(params)
    @cat_type = params[:cat_type]
    @location = params[:user_location]
  end

  def self.search(params)
    best_deal = CatsDealer.best_deal(SearchRequest.new(params))
    p "best_deal: #{best_deal}"
    best_deal
  end
end
