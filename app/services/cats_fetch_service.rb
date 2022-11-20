# frozen_string_literal: true

class CatsFetchService
  SHOPS = %i[cats_unlimited happy_cats].freeze

  def self.call
    response = []

    # Here we can use puts Benchmark.measure to see time execution dependence on threads number
    Parallel.each(SHOPS, in_threads: 2) do |shop|
      shop_service = "#{shop}_service".classify.constantize

      response << shop_service.new.call
    end

    response.flatten
  end
end
