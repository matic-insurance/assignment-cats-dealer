require 'factory_bot'

FactoryBot.define do
  factory :cat do
    breed { 'Abyssin' }
    location { 'Lviv' }
    price { 500 }
    image_src { '' }
    provider_id { 8 }
  end
end
