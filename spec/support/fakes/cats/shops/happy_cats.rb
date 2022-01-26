require_relative '../../../fixtures/cats'

module Fakes
  module Cats
    module Shops
      class HappyCats
        def call
          records = ::Fixtures::Cats.happy_cats.dig(:cats, :cat)
          records.map { |record| ::Cats::Shops::HappyCats.build_record(record) }
        end
      end
    end
  end
end
