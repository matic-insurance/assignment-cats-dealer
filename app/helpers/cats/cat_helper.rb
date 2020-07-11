module Cats
  module CatHelper
    def name(name)
      name.present? ? name : '-' 
    end

    def price(price)
      price.present? ? price : '-'
    end
  end
end
