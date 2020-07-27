module Store
  module Providers
    module Decorators
      class HappyCatDecorator < BaseDecorator
        def decorate
          response[:cats][:cat].map do |item|
            CatStruct.new(
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
end
