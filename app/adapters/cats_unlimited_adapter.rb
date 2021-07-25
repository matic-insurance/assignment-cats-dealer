class CatsUnlimitedAdapter < ApplicationAdapter
  API_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze

  def fetch_all
    response = RestClient.get(API_URL)
    body = JSON.parse(response.body)

    body.map do |cat|
      {
        breed: cat['name'],
        price: cat['price'].to_f,
        location: cat['location'],
        image: cat['image'],
      }
    end
  rescue RestClient::ExceptionWithResponse => e
    raise ServiceError, e.http_body
  end
end
