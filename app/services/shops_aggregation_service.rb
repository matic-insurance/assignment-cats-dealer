class ShopsAggregationService

  def initialize(shops)
    @shops = shops
  end

  def products
    aggregated
  end

  def aggregated
    @aggregated ||= begin
      threads = []
      @shops.each { |shop|
        threads << Thread.new {
          shop.list
        }
      }
      threads.map(&:join).map(&:value).flatten
    end
  end
end