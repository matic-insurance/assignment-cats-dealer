module Fixtures
  class Cats
    def self.happy_cats_xml
      happy_cats.to_xml(root: 'cats')
    end

    def self.happy_cats
      [
        {
          title: 'American Curl',
          cost: '650',
          location: 'Odessa',
          img: 'https://picsum.photos/200'
        },
        {
          title: 'Bengal',
          cost: '800',
          location: 'Odessa',
          img: 'https://picsum.photos/200'
        },
        {
          title: 'Bengal',
          cost: '600',
          location: 'Kyiv',
          img: 'https://picsum.photos/200'
        }
      ]
    end

    def self.cats_unlimited_json
      Oj.dump(cats_unlimited)
    end

    def self.cats_unlimited
      [
        {
          'name' => 'Abyssin',
          'price' => 500,
          'location' => 'Lviv',
          'image' => 'https://picsum.photos/200'
        },
        {
          'name' => 'Devon Rex',
          'price' => 100,
          'location' => 'Kharkiv',
          'image' => 'https://picsum.photos/200'
        },
        {
          'name' => 'American Curl',
          'price' => 450,
          'location' => 'Odessa',
          'image' => 'https://picsum.photos/200'
        }
      ]
    end
  end
end
