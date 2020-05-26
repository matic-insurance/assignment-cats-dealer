desc "Update prices from stores APIs"

task update_prices: :environment do
  ::Store.where(active: true).all.each do |store|
    ::Services::StoreFetcher.new(store).call
  end
end
