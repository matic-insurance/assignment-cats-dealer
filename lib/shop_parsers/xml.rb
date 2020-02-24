module ShopParsers
  class Xml < Json
    def parse(data)
      Hash.from_xml(data).deep_symbolize_keys
    end
  end
end
