require 'providers/clients/base'
require 'providers/parsers/generic_json'

module Providers
  module Clients
    class BestPussycat < Base
      protected

      def parser
        Providers::Parsers::GenericJSON.new
      end

      def hostname
        fetch_variable('BEST_PUSSYCAT_HOST')
      end

      def path
        'dev/cats/json'.freeze
      end
    end
  end
end
