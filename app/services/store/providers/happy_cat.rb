module Store
  module Providers
    class HappyCat < BaseProvider
      extend Callable

      private

      def prepare_result
        Ox.load(response.body, mode: :hash_no_attrs)[:cats][:cat].map do |item|
          ResultStruct.new(
            item[:title],
            item[:cost].to_i,
            item[:location],
            item[:img]
          )
        end
      end
    end
  end
end
