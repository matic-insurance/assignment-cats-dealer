require_relative '../../../fixtures/cats'

module Fakes
  module Cats
    module Shops
      class CatsUnlimited
        def call
          ::Fixtures::Cats.cats_unlimited.map do |record|
            ::Cats::Shops::CatsUnlimited.build_record(record)
          end
        end
      end
    end
  end
end
