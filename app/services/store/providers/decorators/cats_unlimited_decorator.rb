module Store
  module Providers
    module Decorators
      class CatsUnlimitedDecorator < BaseDecorator
        def decorate
          response.map do |item|
            CatStruct.new(
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
end
