module Store
  module Providers
    class CatsUnlimited < BaseProvider
      extend Callable

      private

      def prepare_result
        JSON.parse(response.body).map do |item|
          ResultStruct.new(
            item['name'],
            item['price'].to_i,
            item['location'],
            item['image']
          )
        end
      end
    end
  end
end
