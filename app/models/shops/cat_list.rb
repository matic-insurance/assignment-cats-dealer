# frozen_string_literal: true

module Shops
  class CatList < Array
    def where(params)
      CatList.new(
        select { |c| c.to_h.slice(*params.keys) == params }
      )
    end
  end
end
