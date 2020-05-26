Fabricator(:breed) do
  name { Faker::Creature::Cat.breed }
end
