# stores
Store.create(
  uuid: Nanoid.generate,
  name: 'Cats Unlimited',
  api_endpoint: 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json',
  response_type: 'json',
  active: true,
  mapping: ''
)
Store.create(
  uuid: Nanoid.generate,
  name: 'Happy Cats',
  api_endpoint: 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml',
  response_type: 'xml',
  active: true,
  mapping: '',
)

# cities
City.create(name: 'Lviv')
