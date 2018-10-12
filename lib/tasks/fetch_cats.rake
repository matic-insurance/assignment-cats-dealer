namespace :app do
  namespace :cats do
    task fetch: :environment do
      Cats::Fetch.new().call
    end
  end
end
