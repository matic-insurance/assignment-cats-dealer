module Parsers
  module XML
    private

    def parse
      hash = Hash.from_xml(@response)

      # we need to go deeper :)
      check_hash_for_keys(hash)

      @fetched_items = hash[mapping[:list_name]][mapping[:item_name]]
    end

    def check_hash_for_keys(hash)
      raise 'wrong keys in response' unless hash.key?(mapping[:list_name]) &&
                                            hash[mapping[:list_name]].key?(mapping[:item_name])
    end
  end
end
