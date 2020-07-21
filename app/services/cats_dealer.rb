module CatsDealer
  def self.search(search_request)

    deals = CatsProviders::DEFAULT_PROVIDERS.map do |provider|
      provider.new(search_request).fetch_deals
    end.flatten

    # TODO
    # Array.wrap(best_deal(deals))
    deals
  end

  def self.best_deal(deals)

    Array.wrap(deals.min_by { |deal| deal['price'].to_i }).compact
  end

  private_class_method :best_deal
end
