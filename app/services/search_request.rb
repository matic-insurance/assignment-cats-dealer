class SearchRequest
  attr_reader :cat_type, :location

  def initialize(params)
    @cat_type = params[:cat_type]
    @location = params[:location]
  end

  def self.search(params)
  end
end
