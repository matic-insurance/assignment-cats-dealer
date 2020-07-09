module DealParsers
  class JsonParser
    def self.parse(data, options = {})
      JSON.parse(data.body)
    end
  end
end