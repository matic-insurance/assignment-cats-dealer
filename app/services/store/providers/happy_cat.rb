module Store
  module Providers
    class HappyCat < BaseProvider
      extend Callable

      private

      def parsed_response
        Ox.load(response.body, mode: :hash_no_attrs)
      end

      def prepare_result
        Store::Providers::Decorators::HappyCatDecorator.new(parsed_response).decorate
      end
    end
  end
end
