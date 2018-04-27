module Providers
  module Adapters
    class Base
      def fetch_all
        parsed_response = client.get
        wrap(parsed_response)
      end

      protected

      def client
        raise NotImplementedError
      end

      def base_model
        raise NotImplementedError
      end

      def wrap(parsed_response)
        parsed_response.map do |attributes|
          base_model.new(attributes)
        end
      end
    end
  end
end
