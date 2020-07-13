module CatsDealer
  def self.search(search_request)
    deals = Parallel.map(CatsProviders::DEFAULT_PROVIDERS,
                         in_processes: CatsDealerConfig.parallel_processes) do |provider|
                           provider.new(search_request).fetch_deals
                         end
                    .flatten

    Array.wrap(best_deal(deals))
  end

  def self.best_deal(deals)
    Array.wrap(deals.min_by { |deal| deal['price'].to_i }).compact
  end

  private_class_method :best_deal
end
