require 'nokogiri'

module Providers
  module Parsers
    class GenericXML
      def parse(response_body)
        document = Nokogiri::XML(response_body)
        Hash.from_xml(document.to_s).deep_symbolize_keys
      rescue REXML::ParseException
        empty_results
      end

      private

      def empty_results
        []
      end
    end
  end
end
