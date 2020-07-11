class SearchRequest
  attr_reader :cat_type, :user_location

  def initialize(params)
    @cat_type = params[:cat_type]
    @user_location = params[:user_location]
  end

  def self.search(params)
    CatsDealer.get_deals(SearchRequest.new(params))
  end
end
