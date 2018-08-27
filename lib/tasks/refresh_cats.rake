task :refresh_cats => :environment do

  cats_unlimited_data = CatsUnlimitedShop.new.fetch
  cats_unlimited = Adapters::CatsUnlimited.instantiate(cats_unlimited_data)
  happy_cats_data = HappyCatsShop.new.fetch
  happy_cats = Adapters::HappyCats.instantiate(happy_cats_data)

  if cats_unlimited && happy_cats
    Cat.delete_all
    uniq_cats = (cats_unlimited + happy_cats).uniq
    Cat.create(uniq_cats.map(&:as_json))
  end
end
