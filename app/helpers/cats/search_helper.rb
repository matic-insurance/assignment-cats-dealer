module Cats
  module SearchHelper
    def picture_for(cat)
      image_tag(cat.picture_url, alt: 'Cat Picture', class: 'img-thumbnail small')
    end

    def sort_by_price(cats, ascending: true)
      sorted_cats = cats.sort_by(&:price)
      sorted_cats.reverse! unless ascending
      sorted_cats
    end

    def available_locations
      Cat.locations
    end

    def available_breeds
      Cat.breeds
    end
  end
end
