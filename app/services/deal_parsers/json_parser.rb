module DealParsers
  class JsonParser
    def self.parse(data)
      JSON.parse(data)
    end
  end
end