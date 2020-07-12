class SearchRequest
  attr_reader :breed, :user_location

  def initialize(params)
    @breed = params[:breed]
    @user_location = params[:user_location]
  end
end
