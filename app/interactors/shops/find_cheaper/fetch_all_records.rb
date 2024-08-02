module Shops
  module FindCheaper
    class FetchAllRecords < BaseInteractor
      delegate :records, to: :context # out

      def call
        context.records = fetch_all_records
      end

      private

      def fetch_all_records
        async_tasks = Async do |task|
          shops.map { |service| task.async { service.call } }
        end.wait

        async_tasks.map(&:wait).flatten
      end

      def shops
        @shops = [
          Shops::CatsHappyService,
          Shops::CatsUnlimitedService
        ]
      end
    end
  end
end
