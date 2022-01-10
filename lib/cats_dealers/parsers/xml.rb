module CatsDealers
  module Parsers
    class Xml
      def parse(response_body)
        document = Nokogiri::XML(response_body)
        Hash.from_xml(document.to_s).deep_symbolize_keys
      rescue REXML::ParseException
        []
      end
    end
  end
end
