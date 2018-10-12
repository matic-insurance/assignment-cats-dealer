module Content
  class Adapter
    def initialize(args)
      @fetcher = args.fetch(:fetcher)
      @creator_instance = args.fetch(:creator_instance)
    end

    def call
      content.each do |item|
        @creator_instance.new(
          name: item[:name],
          location: item[:location],
          price: item[:price],
          image: item[:image]
        ).call
      end
    end

    private

    def content
      raise NotImplementedError, self
    end

    def normalize(data, schema)
      raise KeyError, self unless [:name, :location, :price, :image].any? do |key|
        schema.key?(key)
      end

      raise TypeError, self unless data.kind_of?(Array)

      data.map do |item|
        hash = {}

        schema.each do |key, value|
          hash[key] = item[value]
        end

        hash
      end
    end
  end
end
