module Parsers
  module JSON
    private

    def parse
      @fetched_items = MultiJson.load(@response, symbolize_keys: true)
    end
  end
end
