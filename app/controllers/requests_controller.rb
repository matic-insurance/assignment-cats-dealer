class RequestsController < ApplicationController
  def create
    @request = Request.new(
      request_params: request_params,
      product: 'Cat'
    )
    @request.save!
    populate_products
    redirect_to "/cats?request_id=#{@request.id}"
  end

  private

  def request_params
    params.permit(:user_location, :cats_type)
  end

  def populate_products
    all_items = []
    Shop.all.map do |shop|
      # parsing all items from each active shop
      all_items += Parsing::ProductParser.new(shop).call
    end
    # filtering all items by location, type & sorting cats by price
    Comparing::ProductComparator.new(all_items, @request.product, @request.id,
                                     location: request_params[:user_location],
                                     name: request_params[:cats_type]).call
  end
end
