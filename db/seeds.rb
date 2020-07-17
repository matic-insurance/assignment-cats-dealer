CatsProviders::DEFAULT_PROVIDERS.each do |provider|
  p "fetch cats from #{provider} provider"
  cats = provider.new.fetch_deals

  FieldMapings.apply_field_mappings!(cats).each { |cat|
    Cat.create(cat)
  }

  p "Inserted #{Cat.count} into db"
end