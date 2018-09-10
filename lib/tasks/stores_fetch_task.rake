require "#{Rails.root}/lib/store_fetch_logic"

task stores_fetch: [:environment] do
  StoreFetchLogic.perform
end
