module DealParsers
  class JsonParser
    def self.parse(data, _options = {})
      JSON.parse(data.body)
    end
  end
end
