require 'nokogiri'

module Parser
  class XmlParser < BaseParser
    TITLE_KEY = 'title'.freeze
    COST_KEY = 'cost'.freeze
    LOCATION_KEY = 'location'.freeze
    IMG_KEY = 'img'.freeze

    def self.parse_body(xml)
      Nokogiri::XML(xml)
    end

    def self.solidify_keys(doc)
      doc.xpath('//cat').each_with_object([]) do |cat_node, cats_list|
        cat = {
          BaseParser::CAT_TYPE_KEY => cat_node.at_xpath(TITLE_KEY).text,
          BaseParser::PRICE_KEY => cat_node.at_xpath(COST_KEY).text.to_i,
          BaseParser::LOCATION_KEY => cat_node.at_xpath(LOCATION_KEY).text,
          BaseParser::IMAGE_KEY => cat_node.at_xpath(IMG_KEY).text
        }
        cats_list << cat
      end
    end
  end
end
