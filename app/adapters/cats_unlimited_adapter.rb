# frozen_string_literal: true

class CatsUnlimitedAdapter < BaseAdapter
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'

  def cats
    response = request(URL)
    result   = JSON.parse(response.body)

    result.map do |res|
      build_cat(res['name'], res['price'], res['location'], res['image'])
    end
  end
end
