module Shops
  module FindCheaper
    class Organize < BaseOrganizer
      organize FetchAllRecords, FindCheapestRecord
    end
  end
end
