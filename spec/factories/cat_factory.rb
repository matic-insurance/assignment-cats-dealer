FactoryBot.define do
  factory :cat do
    name { Faker::Cat.breed }
    location { Faker::Address.city }
    price { Faker::Commerce.price }
    image { 'https://google.com/some_image.png' }
  end
end
