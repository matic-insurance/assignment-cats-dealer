Fabricator(:city) do
  name { Faker::Address.city }
end
