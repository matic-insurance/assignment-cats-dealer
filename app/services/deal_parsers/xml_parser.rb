module DealParsers
  class XmlParser
    def self.parse(data, options = {})
      Hash.from_xml(data.body)[options[:root_emelent]][options[:child_element]]
    end
  end
end
