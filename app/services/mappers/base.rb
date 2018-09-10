module Mappers
  class Base
    def initialize(klass = Cat)
      @klass   = klass
      @mapping = self.class::MAPPING
      @adapter = self.class::ADAPTER
    end

    def call(raw_data)
      adapter.call(raw_data).map do |row|
        klass.new(map_row(row))
      end
    end

    private

    def map_row(data)
      mapping.map { |l, r| [l, data[r]] }.to_h
    end

    attr_reader :klass, :mapping, :adapter
  end
end
