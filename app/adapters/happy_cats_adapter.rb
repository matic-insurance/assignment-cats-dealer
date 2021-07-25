class HappyCatsAdapter < ApplicationAdapter
  API_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze

  def fetch_all
    response = RestClient.get(API_URL)
    body = Hash.from_xml(response.body)['cats']['cat']

    body.map do |cat|
      {
        breed: cat['title'],
        price: cat['cost'].to_f,
        location: cat['location'],
        image: cat['img'],
      }
    end
  rescue RestClient::ExceptionWithResponse => e
    raise ServiceError, e.http_body
  end
end
