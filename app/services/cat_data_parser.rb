# frozen_string_literal: true

require 'json'
require 'nokogiri'

class CatDataParser
  def self.parse_json(json)
    parsed_json = JSON.parse(json)
    rename_keys(parsed_json)
  end

  def self.parse_xml(xml)
    doc = Nokogiri::XML(xml)

    doc.xpath('//cat').each_with_object([]) do |cat_node, cats_list|
      cat = {
        'cat_type' => cat_node.at_xpath('title').text,
        'price' => cat_node.at_xpath('cost').text.to_i,
        'location' => cat_node.at_xpath('location').text,
        'image' => cat_node.at_xpath('img').text
      }
      cats_list << cat
    end
  end

  def self.rename_keys(object)
    case object
    when Array
      object.map { |item| rename_keys(item) }
    when Hash
      object.each_with_object({}) do |(key, value), result|
        new_key = key == 'name' ? 'cat_type' : key
        new_value = key == 'price' ? value.to_i : rename_keys(value)
        result[new_key] = new_value
      end
    else
      object
    end
  end
end
