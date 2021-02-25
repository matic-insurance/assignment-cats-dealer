class ShopAdapter
  def cats_unlimited
    url    = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
    result = JSON.parse(HTTP.get(url).body)

    result.map do |response|
      Cat.new(
        name:     response['name'],
        location: response['location'],
        price:    response['price'],
        image:    response['image']
      )
    end
  end

  def happy_cats
    url    = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
    result = Nokogiri::XML(HTTP.get(url).body)

    result.xpath('//cat').map do |response|
      Cat.new(
        name:     response.at('title').content,
        location: response.at('location').content,
        price:    response.at('cost').content,
        image:    response.at('img').content
      )
    end
  end
end
