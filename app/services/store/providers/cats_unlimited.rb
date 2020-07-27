module Store
  module Providers
    class CatsUnlimited < BaseProvider
      extend Callable

      private

      def parsed_response
        JSON.parse(response.body)
      end

      def prepare_result
        Store::Providers::Decorators::CatsUnlimitedDecorator.new(parsed_response).decorate
      end
    end
  end
end
