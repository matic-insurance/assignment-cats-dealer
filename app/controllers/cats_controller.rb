class CatsController < ApplicationController
  def new; end

  def search
    cats = SearchRequest.search(search_params)
    redirect_to cats_path({cats: cats})
  end

  def ajax_refresh
    return render(:file => 'reports/create.js.erb')
  end

  def index
    @cats = params['cats'].present? ? params['cats'] : []
  end

  private

  def search_params
    params.permit(:cat_type, :user_location)
  end

end
