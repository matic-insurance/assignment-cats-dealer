class CatsUnlimitedAdapter < BaseAdapter
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'

  def cats
    response = request(URL)
    result   = JSON.parse(response.body)

    result.map do |res|
      RemoteCat.new(
        breed:     res['name'],
        price:     res['price'].to_i,
        location:  res['location'],
        image_url: res['image']
      )
    end
  end
end
