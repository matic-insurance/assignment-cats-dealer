module ShopParsers
  class Json
    def self.parse(data)
      new.parse(data)
    end

    def parse(data)
      JSON.parse(data, symbolize_names: true)
    end
  end
end
