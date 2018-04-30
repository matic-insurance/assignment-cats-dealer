require 'utilities/env_reader'

module Providers
  module Clients
    class Base
      include ENVReader

      def initialize
        @http_connection = Faraday.new(url: hostname)
      end

      def get(params = {})
        response = @http_connection.get(path, params)
        parser.parse(response.body)
      end

      protected

      def parser
        raise NotImplementedError, 'Please implement client specific parser'
      end

      def hostname
        raise NotImplementedError
      end

      def path
        raise NotImplementedError
      end
    end
  end
end
