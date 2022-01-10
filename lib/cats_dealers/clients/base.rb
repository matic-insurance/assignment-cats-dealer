module CatsDealers
  module Clients
    class Base
      def initialize
        @resource = RestClient::Resource.new hostname
        @path = path
      end

      def get(params = {})
        response = @resource.get(@path, params)
        parser.parse(response.body)
      end

      private

      def parser
        raise NotImplementedError
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
