Location.create(name: 'Lviv')
Breed.create(name: 'Siamese')
Cat.create(breed: Breed.first, location: Location.first, cost: 100, image: '')
