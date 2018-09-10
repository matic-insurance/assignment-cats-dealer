FactoryBot.define do
  factory :breed do
    name { %w[Siamese Persian Sphynx].sample }
  end

  factory :location do
    name { %w[Lviv Kharkiv Odessa].sample }
  end

  factory :cat do
    location { Location.find_or_create_by(name: %w[Lviv Kharkiv Odessa].sample) }
    breed { Breed.find_or_create_by(name: %w[Siamese Persian Sphynx].sample) }
    cost { rand(1..100) }
    image { '' }
  end
end
