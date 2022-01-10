module CatsDealers
  module Adapters
    class Base
      class << self
        def list(params = {}, headers = {})
          parsed_response = client.get(params, headers)

          wrap_response(parsed_response)
        end

        private

        def client
          raise NotImplementedError
        end

        def wrap_response(parsed_response)
          raise NotImplementedError
        end
      end
    end
  end
end
