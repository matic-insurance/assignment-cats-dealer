class CatsController < ApplicationController
  def index
    fetching = ::Cats::Fetch.call
    return render(json: fetching.list) if fetching.success?

    render json: { error: fetching.error }, status: 503
  end

  # def result
  #   @cats_list = params[:cats_list].select do |list|
  #     list['location'] == params[:location] && list['name'] == params[:cat_type]
  #   end
  # end
end
