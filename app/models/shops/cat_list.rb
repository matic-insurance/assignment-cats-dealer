# frozen_string_literal: true

module Shops
  class CatList < Array
    def where(params)
      CatList.new(
        select do |c|
          c.to_h.values_at(*params.keys).map(&:downcase) == params.values.map(&:downcase)
        end
      )
    end
  end
end
