module CatsDealer
  class BestDeal
    private
    
    def self.fetch(deals)
      deals.max { |deal_x, deal_z| deal_x['price'] <=> deal_z['price'] }
    end
  end

  def self.get_deals(search_request)
    Parallel.map(CatsProviders::DEFAULT_PROVIDERS, in_processes: CatsDealerConfig.parallel_processes) { |provider| provider.get_deals(search_request) }
            .flatten
  end

  def self.best_deal(search_request)
    deals = self.get_deals(search_request)
    deals.size == 1 ? deals : BestDeal.fetch(deals)
  end
end
