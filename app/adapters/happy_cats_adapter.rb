class HappyCatsAdapter < BaseAdapter
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'

  def cats
    response = request(URL)
    result   = Hash.from_xml(response.body)['cats']['cat']

    result.map do |res|
      RemoteCat.new(
        breed:     res['title'],
        price:     res['cost'].to_i,
        location:  res['location'],
        image_url: res['img']
      )
    end
  end
end
