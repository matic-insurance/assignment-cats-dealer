module Sources
  class Base
    def initialize
      @mapper = self.class.name.gsub('Sources', 'Mappers').constantize.new
      @source_url = self.class::SOURCE_URL
    end

    def data
      @data ||= mapper.call(raw_data)
    end

    private

    def raw_data
      @raw_data ||= RestClient.get(source_url).body
    end

    attr_reader :mapper, :source_url
  end
end
