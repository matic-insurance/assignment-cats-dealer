CatsProviders::DEFAULT_PROVIDERS.each do |provider|

  # seed providers
  cat_provider = Provider.create(name: provider.to_s.demodulize)

  cats = CatsImporter.execute(provider.new)

  # seed locations
  cities = cats.map { |cat| cat[:location] }.uniq
  cities.each { |city|
    location = Location.create(city: city, provider_name: cat_provider.name)
    cat_provider.locations << location
    cat_provider.address = location.city
    cat_provider.save
  }

  # seed cats
  cats.each { |cat|
    cat_provider.cats.create(cat)
  }

  p "Inserted #{Cat.count} into db"
end
