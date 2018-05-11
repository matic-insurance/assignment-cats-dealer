class HappyCatsShop
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
  FIELDS_MAPPER = {
    title: 'breed',
    cost: 'price',
    img: 'image'
  }.with_indifferent_access
  NAME = 'Happy Cats'
  MODEL = Cat

  def list
    @list ||= wrap(enrich_with_name(map_fields(parse(request))))
  end

  def request
    RestClient.get(URL)
  end

  def parse(response)
    Nokogiri::Slop(response.body).cats.cat.map {
      |cat| Hash.from_xml(cat.to_s).with_indifferent_access[:cat]
    }
  end

  def map_fields(list)
    list.map { |item|
      item.map {
      | field, value| [FIELDS_MAPPER[field] || field, value]
      }.to_h.with_indifferent_access
    }
  end

  def enrich_with_name(list)

    list.each { |item| item['shop'] = NAME }
  end

  def wrap(list)
    list.map{|item| MODEL.new(item)}
  end
end