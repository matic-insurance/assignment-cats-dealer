module CatsDealer
  def self.search(search_request)

    deals = CatsProviders::DEFAULT_PROVIDERS.map do |provider|
      provider.new(search_request).fetch_deals
    end.flatten

    Filters.new(deals, search_request).execute
  end
end
