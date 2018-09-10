namespace :cats do
  desc 'Truncate Location, Breed & Cat tables'
  task resetdb: :environment do
    Cat.delete_all
    Breed.delete_all
    Location.delete_all
  end

  desc 'Fetch cats data & populate the db'
  task aggregate: :environment do
    CatsAggregator.new.call
  end
end
