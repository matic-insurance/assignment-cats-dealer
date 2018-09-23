class RequestsController < ApplicationController
  def get_kitties
    cat_breed = params[:cat_breed]
    location = params[:location]

    kitties_list = []
    kitties_list << get_data_from_json(cat_breed, location)
    kitties_list << get_data_from_xml(cat_breed, location)

    redirect_to root_path(kitties_list: kitties_list.flatten)
  end

  def get_data_from_json(cat_breed, location)
    get_data_from_json = RestClient::Request.execute(
      method: :get,
      url: 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json',
    )

    kitties_list_from_json = JSON.parse(get_data_from_json)
                       .select { |list| list['location'] == location && list['name'] == cat_breed }
  end

  def get_data_from_xml(cat_breed, location)
    get_data_from_xml = RestClient::Request.execute(
      method: :get,
      url: 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml',
    )

    kitties_list_from_xml = parse_xml(get_data_from_xml, cat_breed, location)
  end

  def parse_xml(get_data_from_xml, cat_breed, location)
    doc = Nokogiri::XML(get_data_from_xml)

    kitties_list_from_xml = []
    kitties_hash = {}

    doc.xpath('//cats/cat').each do |kittie|
      
      if kittie.children[0].children.text == cat_breed && kittie.children[2].children.text == location
        kitties_hash[:name] = kittie.children[0].children.text
        kitties_hash[:price] = kittie.children[1].children.text.to_i
        kitties_hash[:location] = kittie.children[2].children.text
        kitties_hash[:image] = kittie.children[3].children.text

        kitties_list_from_xml << kitties_hash.stringify_keys
      end
    end

    kitties_list_from_xml
  end
end
