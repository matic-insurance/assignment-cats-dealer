require 'nokogiri'
require 'logger'

module Providers
  module Parsers
    class GenericXML
      def parse(response_body)
        document = Nokogiri::XML(response_body)
        Hash.from_xml(document.to_s).deep_symbolize_keys
      rescue REXML::ParseException => error
        Rails.logger.error("[Parsers::GenericXML] Unable to parse response, #{error}")
        empty_result
      end

      private

      def empty_result
        {}
      end
    end
  end
end
