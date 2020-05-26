module Parsers
  module XML

    private

    def parse
      # TODO: in case of complicated parsing:
      # 1. break glass
      # 2. use Nokogiri

      initial_hash = Hash.from_xml(RestClient.get(@url))

      # we need to go deeper :)
      @fetched_items = initial_hash[mapping[:list_name].to_s][mapping[:item_name].to_s]
    end
  end
end
