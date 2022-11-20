# frozen_string_literal: true

class HappyCatsService < BaseClientService
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'

  private

  def format_response(response, shop_name)
    body = Hash.from_xml(response.body)['cats']['cat']

    body.map do |cat|
      Cat.new(
        type: cat['title'],
        price: BigDecimal(cat['cost']),
        location: cat['location'],
        image: cat['img'],
        shop_name: shop_name
      )
    end
  end
end
