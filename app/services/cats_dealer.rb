module CatsDealer
  def self.get_deals(search_request)
    deals = Parallel.map(CatsProviders::DEFAULT_PROVIDERS, in_processes: CatsDealerConfig.parallel_processes) { |provider| provider.get_deals(search_request) }
            .flatten

    deals.size == 1 ? deals : Array.wrap(self.best_deal(deals))
  end

  private
  def self.best_deal(deals)
    deals.min_by { |deal| deal['price'].to_i }
  end
end
