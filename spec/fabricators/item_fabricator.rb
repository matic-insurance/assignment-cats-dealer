Fabricator(:item) do
  price           { Faker::Number.number(digits: 3) }
  uuid            { Nanoid.generate }
  active          { true }
  price_currency  { 'uah' }
  img_url         { Faker::Avatar.image }
  store           { Fabricate(:store_with_json_response) }
  breed           { Fabricate(:breed) }
  city            { Fabricate(:city) }
end
