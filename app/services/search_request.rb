class SearchRequest
  attr_reader :cat_type, :user_location

  def initialize(params)
    @cat_type = params[:cat_type]
    @user_location = params[:user_location]
  end
end
