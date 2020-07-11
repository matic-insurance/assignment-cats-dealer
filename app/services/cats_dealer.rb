module CatsDealer
  def self.search(search_request)
    deals = Parallel.map(CatsProviders::DEFAULT_PROVIDERS,
                         in_processes: CatsDealerConfig.parallel_processes) do |provider|
                           provider.new(search_request).fetch_deals
                         end
                    .flatten

    deals.size == 1 ? deals : Array.wrap(best_deal(deals))
  end

  def self.best_deal(deals)
    deals.min_by { |deal| deal['price'].to_i }
  end
end
