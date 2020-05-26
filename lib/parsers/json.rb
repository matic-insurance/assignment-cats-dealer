module Parsers
  module JSON

    private

    def parse
      @fetched_items = MultiJson.load(RestClient.get(@url), :symbolize_keys => true)
    end
  end
end
