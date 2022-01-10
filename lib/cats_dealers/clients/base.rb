module CatsDealers
  module Clients
    class Base
      def get(params = {}, headers = {})
        execute_request do
          response = RestClient::Request.execute(
            method: :get,
            url: url,
            headers: headers,
            params: params
          )
          parser.parse(response.body)
        end
      end

      def execute_request
        yield
      rescue RestClient::RequestFailed
        []
      end

      private

      def parser
        raise NotImplementedError
      end

      def url
        raise NotImplementedError
      end
    end
  end
end
