module Cats
  class GetValues
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def call
      result = ActiveRecord::Base.connection.exec_query(
        <<-SQL
          SELECT DISTINCT #{value} FROM cats;
        SQL
      )

      result.to_a.map{ |x| x[value] }.compact
    end
  end
end
