module Store
  module Providers
    class BaseProvider
      ResultStruct = Struct.new(:title, :price, :location, :image)

      def initialize(params)
        @configuration = params.fetch(:configuration)
      end

      def perform
        make_request
        prepare_result
      end

      private

      attr_reader :configuration,
                  :response

      def make_request
        @response = RestClient.get(configuration[:url])
      end

      def prepare_result
        raise NotImplementedError
      end
    end
  end
end

