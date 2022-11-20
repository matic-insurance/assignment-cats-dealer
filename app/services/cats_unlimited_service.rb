# frozen_string_literal: true

class CatsUnlimitedService < BaseClientService
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'

  private

  def format_response(response, shop_name)
    body = JSON.parse(response.body)

    body.map do |cat|
      Cat.new(
        type: cat['name'],
        price: BigDecimal(cat['price']),
        location: cat['location'],
        image: cat['image'],
        shop_name: shop_name
      )
    end
  end
end
