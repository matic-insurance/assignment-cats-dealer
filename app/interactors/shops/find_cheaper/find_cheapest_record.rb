module Shops
  module FindCheaper
    class FindCheapestRecord < BaseInteractor
      delegate :query_params, :records, to: :context # in
      delegate :record, to: :context # out

      def call
        context.record = find_cheapest_record
      end

      private

      def find_cheapest_record
        ::Shops::CheapestCatQuery.new(query_params, records).call
      end
    end
  end
end
