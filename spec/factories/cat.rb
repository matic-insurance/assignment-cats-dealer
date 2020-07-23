require 'factory_bot'

FactoryBot.define do
  factory :super_cat do
    breed { 'Abyssin' }
    location  { 'Kyiv' }
    price { 500 }
    image_src { '' }
    provider_id { 8 }
  end
end