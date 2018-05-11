class UnlimitedCatsShop
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
  FIELDS_MAPPER = {
    name: 'breed',
  }.with_indifferent_access

  NAME = 'Cats Unlimited'
  MODEL = Cat

  def list
    @list ||= wrap(enrich_with_name(map_fields(parse(request))))
  end

  def request
    RestClient.get(URL)
  end

  def parse(response)
    JSON.parse(response.body)
  end

  def map_fields(list)
    list.map { |item|
      item.map {
        | field, value| [FIELDS_MAPPER[field] || field, value]
      }.to_h.with_indifferent_access
    }
  end

  def enrich_with_name(cats_list)
    cats_list.each {|cat| cat['shop'] = NAME }
  end

  def wrap(list)
    list.map{|item| MODEL.new(item)}
  end
end