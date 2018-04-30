require 'providers/models/kitty_shop'
require 'providers/models/best_pussycat'

FactoryBot.define do
  factory :cat do
    breed 'Typical'
    price 500
    location 'Lviv'
    picture_url 'http://dummy.com/image.png'

    trait :purebred do
      breed 'Pedigree'
    end

    trait :in_odessa do
      location 'Odessa'
    end
  end

  factory :best_pussycat, class: Providers::Models::BestPussycat do
    skip_create

    name 'Typical'
    price 500
    location 'Lviv'
    image 'http://dummy.com/image.png'

    initialize_with { new(attributes) }
  end

  factory :kitty_shop_cat, class: Providers::Models::KittyShop do
    skip_create

    title 'Typical'
    cost 500
    location 'Lviv'
    img 'http://dummy.com/image.png'

    initialize_with { new(attributes) }
  end
end
